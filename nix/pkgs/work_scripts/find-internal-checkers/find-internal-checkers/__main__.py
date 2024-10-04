#!/usr/bin/env python3

import argparse
import sys
import os
import re
import subprocess
import textwrap as tw
from enum import Enum
from math import floor, ceil

import xml.etree.ElementTree as ET

SBROOT = None
JOBARCHIVE = None

INTERNAL_COMPONENT = None

def get_environ(name):
    try:
        return os.environ[name]
    except KeyError:
        return None

def check_envir():
    """Check the environment variables."""
    global SBROOT
    SBROOT = get_environ("r")
    global JOBARCHIVE
    JOBARCHIVE = get_environ("j")

#  ____
# |  _ \ __ _ _ __ ___  ___    __ _ _ __ __ _ ___
# | |_) / _` | '__/ __|/ _ \  / _` | '__/ _` / __|
# |  __/ (_| | |  \__ \  __/ | (_| | | | (_| \__ \
# |_|   \__,_|_|  |___/\___|  \__,_|_|  \__, |___/
#                                       |___/

def _filetype():
    def checker(string):
        if os.path.isfile(string):
            return string
        else:
            msg = "file {} not found".format(string)
            raise argparse.ArgumentTypeError(msg)

    return checker

def _dirtype():
    def checker(string):
        if os.path.isdir(string):
            return string
        else:
            msg = "dir {} not found".format(string)
            raise argparse.ArgumentTypeError(msg)

    return checker

class MatcherType(Enum):
    EXTENDED=1
    FIXED=2
    BASIC=3


def parse_args():
    "Parses catalogs to get internal checkers."
    parser = argparse.ArgumentParser(
        description="""Finds internal checkers associated to external checkers.
        Uses $r environment variable or `p4 info` to locate sandbox."""
    )
    parser.add_argument(
        "id",
        metavar="ID",
        type=str,
        help="A checker id",
        nargs="+",
    )

    parser.add_argument(
        "-r",
        "--reverse",
        default=False,
        action="store_true",
        dest="reverse",
        help="Reverse the search, finds external checker associated to internal checker",
    )

    parser.add_argument(
        "-d",
        "--catalog-dir",
        type=_dirtype(),
        action="store",
        metavar="DIR",
        default=None,
        dest="catalog_dir",
        help="The directory to find catalogs"
    )

    parser.add_argument(
        "-f",
        "--catalog-file",
        type=_filetype(),
        action="store",
        metavar="FILE",
        default=None,
        dest="catalog_file",
        help="The catalog file"
    )

    matcher = parser.add_argument_group("matcher selection",
                                        description="""As with grep, you can
                                        search with various matcher.""")
    matcher.add_argument(
        "-E",
        "--extended-regexp",
        action="store_const",
        help="Interpret PATTERNS as extended regular expressions",
        dest="matcher",
        const=MatcherType.EXTENDED,
        default=MatcherType.BASIC
    )

    matcher.add_argument(
        "-F",
        "--fixed-regexp",
        action="store_const",
        help="Interpret PATTERNS as fixed regular expressions",
        dest="matcher",
        const=MatcherType.FIXED,
        default=MatcherType.BASIC
    )

    matcher.add_argument(
        "-G",
        "--basic-regexp",
        action="store_const",
        help="Interpret PATTERNS as basic regular expressions",
        dest="matcher",
        const=MatcherType.BASIC,
        default=MatcherType.BASIC
    )

    matcher.add_argument(
        "--filter-by-component",
        action="store",
        type=str,
        dest="component_filter",
        help="Filter internal checker by component, e.g., Module, Compile...",
        default=""
    )

    args = parser.parse_args()

    if args.catalog_file and args.catalog_dir:
        print(
            "Warning: -f and -d options are mutually exclusive",
            file=sys.stderr,
        )

    return args

#  ____                                 _        _
# |  _ \ __ _ _ __ ___  ___    ___ __ _| |_ __ _| | ___   __ _ ___
# | |_) / _` | '__/ __|/ _ \  / __/ _` | __/ _` | |/ _ \ / _` / __|
# |  __/ (_| | |  \__ \  __/ | (_| (_| | || (_| | | (_) | (_| \__ \
# |_|   \__,_|_|  |___/\___|  \___\__,_|\__\__,_|_|\___/ \__, |___/
#                                                        |___/


def pretty_print_section(section):
    print ("In section {}:".format(section.attrib["name"]))

def description_or_name(attrib):
    try:
        return attrib["description"]
    except KeyError:
        try:
            return attrib["name"]
        except KeyError:
            return ""

def sanitize_id(id_name):
    if ARGS.matcher == MatcherType.BASIC:
        return re.sub(r"[ _]", "-", id_name).upper()
    else:
        return id_name

def sanitize_search(search_string):
    if ARGS.matcher != MatcherType.BASIC:
        return search_string
    else:
        search_string = sanitize_id(search_string)
        search_string = re.sub(r"([.^$+{}\\[\]()|])", r"\\\1", search_string)
        search_string = re.sub(r"\*", ".*", search_string)
        return re.sub(r"\?", ".", search_string)

def pretty_print_external_check(check):
    wrapper = tw.TextWrapper(initial_indent=(" "*(len(check.attrib["id"])+13)),
        subsequent_indent=("  |"+" "*(len(check.attrib["id"])+10)))
    print('  + Check {}: "{}"'.format(check.attrib["id"], wrapper.fill(description_or_name(check.attrib)).strip()))
    for mapping in check.iter("mapping"):
        print("  |--> {}".format(mapping.attrib["ids"]))

def pretty_print_internal_check(internal, checks):
    print('  + Internal checker {} in {}:'.format(internal, INTERNAL_COMPONENT[internal]))
    for check in checks:
        wrapper = tw.TextWrapper(initial_indent=(" "*(len(check.attrib["id"])+10)),
            subsequent_indent=("  |"+" "*(len(check.attrib["id"])+7)))
        print('  |--> {}: "{}"'.format(check.attrib["id"], wrapper.fill(description_or_name(check.attrib)).strip()))

def search_in(pattern_list, v, filter=lambda x : x):
    for pattern in pattern_list:
        if ARGS.matcher != MatcherType.FIXED:
            if re.search(sanitize_search(pattern), filter(v)) is not None:
                return True
        else:
            if sanitize_search(pattern) in filter(v):
                return True
    return False

def get_internal_checker_component(file_name, filter):
    ret = {}
    tree = ET.ElementTree(file=file_name)
    root = tree.getroot()
    for check in root.iter("check"):
        check_id = check.attrib["id"]
        check_component = check.attrib["component"]
        if filter != "":
            if filter == check_component:
                ret[check_id] = check_component
        else:
            ret[check_id] = check_component
    return ret

def search_internal_in_file(file_name, check_id):
    to_print = {}
    tree = ET.ElementTree(file=file_name)
    root = tree.getroot()
    for section in root.iter("section"):
        for check in section.iter("check"):
            if search_in(check_id, check.attrib["id"], filter=sanitize_id):
                try:
                    to_print[section] += [check]
                except KeyError:
                    to_print[section] = [check]
    if to_print != {}:
        nl = floor((68-len(root.attrib["name"]))/2)
        nr = ceil((68-len(root.attrib["name"]))/2)
        print ("-"*nl + " {} ".format(root.attrib["name"]) + "-"*nr)
    for k, v in to_print.items():
        pretty_print_section(k)
        for v in v:
            pretty_print_external_check(v)
        print("")


def search_external_in_file(file_name, check_id):
    to_print = {}
    tree = ET.ElementTree(file=file_name)
    root = tree.getroot()
    for section in root.iter("section"):
        for check in section.iter("check"):
            for mapping in check.iter("mapping"):
                if search_in(check_id, mapping.attrib["ids"], filter=sanitize_id) and mapping.attrib["ids"] in INTERNAL_COMPONENT:
                    try:
                        to_print[section][mapping.attrib["ids"]] += [check]
                    except KeyError:
                        try:
                            to_print[section][mapping.attrib["ids"]] = [check]
                        except KeyError:
                            to_print[section] = {mapping.attrib["ids"] : [check]}
    if to_print != {}:
        nl = floor((68-len(root.attrib["name"]))/2)
        nr = ceil((68-len(root.attrib["name"]))/2)
        print ("-"*nl + " {} ".format(root.attrib["name"]) + "-"*nr)
    for k, v in to_print.items():
        pretty_print_section(k)
        for k, v in v.items():
            pretty_print_internal_check(k, v)
        print("")


def get_files(directory):
    regex = re.compile(r'.*_catalog\.xml')
    l = []
    if directory is not None:
        for root, dirs, files in os.walk(directory):
            for file in files:
                if regex.match(file):
                    l += [directory + "/" + file]
    return l


def get_p4_root():
    v = subprocess.check_output(["p4", "info"]).decode("utf-8")
    m = re.search ("Client root: [^ \n]+", v)
    if m is not None:
        return m.group(0).split(" ")[2]
    return None

def main():
    check_envir()
    global SBROOT
    global JOBARCHIVE
    args = parse_args()
    global ARGS
    ARGS = args
    files = None
    if args.catalog_dir:
        files = get_files(args.catalog_dir)
    elif args.catalog_file:
        files = [args.catalog_file]
    elif SBROOT is not None:
        files = get_files(SBROOT + "/matlab/polyspace/src/shared/definitions/catalogs")
    else:
        r = get_p4_root()
        if r is not None:
            files = get_files(r + "/matlab/polyspace/src/shared/definitions/catalogs")
        elif JOBARCHIVE is not None:
            print("Warning: searching catalogs in {}"
                  .format(JOBARCHIVE + "/Bpolyspace_lang/latest_pass/matlab/polyspace/src/shared/definitions/catalogs"),
                  file=sys.stderr)
            files = get_files(JOBARCHIVE + "/Bpolyspace_lang/latest_pass/matlab/polyspace/src/shared/definitions/catalogs")
    if files is None or files == []:
        print(
            "Error: no catalog to parse",
            file=sys.stderr,
        )
        sys.exit(1)

    global INTERNAL_COMPONENT

    # In order to get it working quickly
    # get the internal_checkers_catalog.xml file
    for f in files:
        if "internal_checkers_catalog.xml" in f:
            INTERNAL_COMPONENT = get_internal_checker_component(f, args.component_filter)

    for file in files:
        if args.reverse:
            search_external_in_file(file, args.id)
        else:
            search_internal_in_file(file, args.id)

if __name__ == "__main__":
    main()

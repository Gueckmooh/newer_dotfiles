# Add the good perl to the path
export PATH=/mathworks/hub/share/apps/BuildTools/Linux/glibc-2.13/x86_64/perl/perl-5.34.1-mw-002/bin:$PATH

export PATH="$PATH:$HOME/.local/pst/bin"
export PATH="$PATH:$HOME/.local/bin"

# Set NORMAL_PATH for the following trap
export NORMAL_PATH=$PATH

# On each action, check if we are in a sbs sandbox
# If this is the case, change the path and set some stuff
do_on_cd() {
	if echo $PWD | grep -E "/mathworks/devel/sbs/[0-9]+/$USER.*" >/dev/null; then
		P=$(echo $PWD | grep -Eo "/mathworks/devel/sbs/[0-9]+/$USER\.[^/]*")
		export PATH=$NORMAL_PATH:$P/matlab/test/tools/polyspace/btv/:$P/matlab/polyspace/bin:$P/bin:$P/matlab/bin/glnxa64:$P/matlab/polyspace/bin/glnxa64
		export SBROOT=$P
		export r="$SBROOT"
		export MATLAB=$r/matlab
	elif echo "$PWD" | grep -E "/local-ssd/$USER/Bpolyspace_.*" >/dev/null; then
		P=$(echo $PWD | grep -Eo "/local-ssd/$USER/Bpolyspace_.[^/]*")
		export PATH=$NORMAL_PATH:$P/matlab/test/tools/polyspace/btv/:$P/matlab/polyspace/bin:$P/bin:$P/matlab/bin/glnxa64:$P/matlab/polyspace/bin/glnxa64
		export SBROOT=$P
		export r="$SBROOT"
	else
		export PATH=$NORMAL_PATH
		unset SBROOT
		unset r
		unset MATLAB
	fi
	if ! test -z "$VIRTUAL_ENV"; then
		export PATH="$VIRTUAL_ENV/bin:$PATH"
	fi
}

trap do_on_cd DEBUG

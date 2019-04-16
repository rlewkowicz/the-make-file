#scripts inherntly will not allow you to set aliases for themseleves unless you force it
shopt -s expand_aliases
#I'm wrting this for GNU systems and expect the gnu-utils brew package.
command -v gsed >/dev/null 2>&1 && alias sed=gsed


# So this bit is a little heavy. What we're doing is finding all files
# that have the .template suffix and we make a copy of it. We then
# perform a sed based on the vars we set on .env. The interp section forces
# interpolation of the varibles before it seds them
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $DIR/.env
templates=`find $DIR -type f | grep \.template$`
for template in $templates ; do
	(
	final=$(echo $template | awk -F'\\.template$' '{print $1}')
  cat $template > $final
  for var in `cat $DIR/.env | grep "[^a-z]=" | awk -F'=' '{print $1}'`; do
    interp=$(eval echo $`echo ${var}`) #we're forcing interpolation of varibles that require calculation
    sed -i "s#\%$var\%#$interp#g" $final
  done
  echo $final | awk -F'/' '{print $NF}' | grep \\.sh$ &> /dev/null
    if [ $? == 0 ]; then
      chmod 700 $final
    fi
	 )&
done
## ()& puts each loop in a sub shell and puts it in the back ground.
## Essentially making it threaded 


wait

#! /bin/bash
# shankszhang 2019-09-10

g_all_file_path=".ctags_file_path"

TURN_COLOR_ON='\033[1;36m'
TURN_COLOR_OFF='\033[0m'
function echo_colorfully()
{
	echo -e "$TURN_COLOR_ON$1$TURN_COLOR_OFF"
}

function find_all_file()
{
    working_path=$1
    source_path=$2

    cd $working_path
    root_path=$(pwd | sed 's$\/$\\\/$g')
    echo_colorfully "...On_Find_AllFiles..."
    echo $source_path

    find $source_path -name "*.h" -o -name "*.cpp" -o -name "*.cc" -o -name "*.c"| sed "s/^\./$root_path/" > $g_all_file_path 
    cd - >/dev/null
}

function make_ctags()
{
    working_path=$1;cd $working_path
	echo_colorfully "...On_Make_CTags..."
    ctags -L $g_all_file_path --languages=c++ --c++-kinds=+px --fields=+aiKSz --extra=+q
    cd - >/dev/null
}

function make_cscope()
{
    working_path=$1;cd $working_path
    cscope -bkq -i $g_all_file_path
    cd - >/dev/null
}

function clean()
{
    working_path=$1; cd $working_path; rm cscope.*; rm tags; rm $g_all_file_path
}

function make_ycm_conf()
{
    working_path=$1
    project_name=`basename $working_path`
    cp ~/.vim/script/ycm_extra_conf.py ~/.vim/script/.ycm_extra_conf.py
    sed -i "s/placeholder/$project_name/g" ~/.vim/script/.ycm_extra_conf.py
    mv ~/.vim/script/.ycm_extra_conf.py $working_path/
}

function main()
{
	working_path=`pwd`

    clean $working_path

    echo_colorfully "==========Start_Make_Ctags================="

    if [[ $working_path =~ "sgame" ]] || [[ $working_path =~ "VersionBranch" ]] || [[ $working_path =~ "main_version" ]]
	then
        source_path=("$working_path/common/funcs"
					 "$working_path/common/template"
					 "$working_path/common/transfer"
					 "$working_path/common/object"
					 "$working_path/common/ipc"
					 "$working_path/common/http"
					 "$working_path/common/protocol"
					 "$working_path/define"
					 "$working_path/zone/game"
                     )
        echo_colorfully "WorkingPath:"$working_path
        find_all_file $working_path "${source_path[*]}"
        make_ctags $working_path
        make_cscope $working_path
        make_ycm_conf $working_path
	else
		source_path=$working_path
        find_all_file $working_path $source_path
        make_ctags  $working_path
        make_cscope $working_path
	fi

    echo_colorfully "==========Job_Done_Success================="
}

main

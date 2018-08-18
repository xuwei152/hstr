#!/bin/bash
#
# Copyright (C) 2014-2018  Martin Dvorak <martin.dvorak@mindforger.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Run HSTR w/ 1 history entry to hunt memleaks w/ valgrind

# compile
cd .. && qmake CONFIG+=hstrdebug hstr.pro && make clean && make -j 8
if [ ${?} -ne 0 ]
then
    exit 1
fi

# test history file
#export HISTFILE=`pwd`/test/resources/.bash_history_valgrind_empty
export HISTFILE=`pwd`/test/resources/.bash_history_valgrind_1_entry

# Valgrind
valgrind --track-origins=yes --tool=memcheck --leak-check=full --show-leak-kinds=all ./hstr -n hist
# Valgrind's GDB
#valgrind --vgdb=yes --vgdb-error=0 --track-origins=yes --tool=memcheck --leak-check=full --show-leak-kinds=all ./hstr -n hist

# eof
# Copyright 2017-present Open Networking Foundation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# markdownlint(mdl) strict rules file
# To use: `make LINT_STYLE=mdl_strict.rb lint`
#
# Rule descriptions:
#  https://github.com/markdownlint/markdownlint/blob/master/docs/RULES.md
# Instructions on modifying the rules file:
#  https://github.com/markdownlint/markdownlint/blob/master/docs/creating_styles.md

# use all rules
all

# Indent lists with 4 spaces
rule 'MD007', :indent => 4

# Don't enforce line length limitations within code blocks and tables
rule 'MD013', :code_blocks => false, :tables => false

# Allow  ! and ? as trailing punctuation in headers
rule 'MD026', :punctuation => '.,;:'

# Numbered lists should have the correct order
rule 'MD029', :style => "ordered"


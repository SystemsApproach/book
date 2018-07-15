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

# markdownlint(mdl) relaxed rules file
#
# Rule descriptions:
#  https://github.com/markdownlint/markdownlint/blob/master/docs/RULES.md
# Instructions on modifying the rules file:
#  https://github.com/markdownlint/markdownlint/blob/master/docs/creating_styles.md

# use all rules
all

# Indent lists with 4 spaces
rule 'MD007', :indent => 4

# Exclude rule: Trailing spaces
exclude_rule 'MD009'

# Don't enforce line length limitations within code blocks and tables
rule 'MD013', :code_blocks => false, :tables => false

# Allow  ! and ? as trailing punctuation in headers
rule 'MD026', :punctuation => '.,;:'

# Exclude rule: Multiple spaces after blockquote symbol
exclude_rule 'MD027'

# Numbered lists should have the correct order
rule 'MD029', :style => "ordered"

# Allow Bare URLs
exclude_rule 'MD034'

# Allow copyright notice as an HTML comment before top level header
exclude_rule 'MD041'

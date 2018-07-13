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

# Exclude rule: Header levels should only increment by one level at a time
exclude_rule 'MD001'

# Indent lists with 4 spaces
rule 'MD007', :indent => 4

# Exclude rule: Trailing spaces
exclude_rule 'MD009'

# Don't enforce line length limitations
exclude_rule 'MD013'

# Allow  ! and ? as trailing punctuation in headers
rule 'MD026', :punctuation => '.,;:'

# Exclude rule: Multiple spaces after blockquote symbol
exclude_rule 'MD027'

# Numbered lists should have the correct order
rule 'MD029', :style => "ordered"

# Exclude rule: Fenced code blocks should be surrounded by blank lines
exclude_rule 'MD031'

# Exclude rule: Emphasis used instead of a header
exclude_rule 'MD036'

# Gitbook won't care about multiple blank lines
exclude_rule 'MD012'

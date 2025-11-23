; Keywords
["struct" "enum"] @keyword

; Attributes
(attribute) @attribute

; Types
(primitive_type) @type.builtin
(solana_type) @type.builtin
(identifier) @type

; Fields
(field name: (identifier) @variable.member)

; Enum variants
(enum_variant (identifier) @constant)

; Comments
(line_comment) @comment
(block_comment) @comment

; Strings
(string_literal) @string

; Punctuation
["{" "}" "[" "]" "<" ">"] @punctuation.bracket
[":" ","] @punctuation.delimiter

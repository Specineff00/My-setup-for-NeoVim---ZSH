-- ============================================================================
-- nvim-surround: Add/change/delete surrounding characters
-- ============================================================================
--
-- ADDING SURROUNDINGS (ys = "you surround"):
--   ysiw"    → Surround word with "       hello  →  "hello"
--   ysiw)    → Surround word with ()      hello  →  (hello)
--   ysiw}    → Surround word with {}      hello  →  {hello}
--   yss"     → Surround whole line        hello world  →  "hello world"
--   ysiw<div>→ Surround with HTML tag     hello  →  <div>hello</div>
--
-- CHANGING SURROUNDINGS (cs = "change surrounding"):
--   cs"'     → Change " to '              "hello"  →  'hello'
--   cs"(     → Change " to ()             "hello"  →  (hello)
--   cs)]     → Change () to []            (hello)  →  [hello]
--   cst<span>→ Change HTML tag            <div>x</div>  →  <span>x</span>
--
-- DELETING SURROUNDINGS (ds = "delete surrounding"):
--   ds"      → Delete "                   "hello"  →  hello
--   ds(      → Delete ()                  (hello)  →  hello
--   dst      → Delete HTML tag            <div>hello</div>  →  hello
--
-- VISUAL MODE:
--   S"       → Surround selection with "  (select text first, then S")
--
-- BRACKET TYPES:
--   ( or )   → No spaces:  (hello)
--   { or }   → No spaces:  {hello}
--   [ or ]   → No spaces:  [hello]
--   b        → Alias for )
--   B        → Alias for }
--
-- COMMON PATTERNS:
--   ysiw"    → Quote a word
--   cs"'     → Double to single quotes
--   ds"      → Remove quotes
--   ysiw)i\  → Swift interpolation: name → \(name)
--
-- ============================================================================
return {
  "kylechui/nvim-surround",
  event = "BufRead",
  config = true,
}
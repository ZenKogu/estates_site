# @createRange = (node, chars, range) ->
#   if !range
#     range = document.createRange()
#     range.selectNode node
#     range.setStart node, 0
#   if chars.count == 0
#     range.setEnd node, chars.count
#   else if node and chars.count > 0
#     if node.nodeType == Node.TEXT_NODE
#       if node.textContent.length < chars.count
#         chars.count -= node.textContent.length
#       else
#         range.setEnd node, chars.count
#         chars.count = 0
#     else
#       lp = 0
#       while lp < node.childNodes.length
#         range = createRange(node.childNodes[lp], chars, range)
#         if chars.count == 0
#           break
#         lp++
#   range

# @setCurrentCursorPosition = (el,chars) ->
#   if chars >= 0
#     selection = window.getSelection()
#     range = createRange(el.parentNode, count: chars)
#     if range
#       range.collapse false
#       selection.removeAllRanges()
#       selection.addRange range
#   return

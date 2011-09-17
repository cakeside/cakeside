function hideSelectBoxes(object)
{
	if (!object) return;
	if (!object.sboxes)
		object.sboxes = [];
	var ol = getElementX(object);
	var ot = getElementY(object);
	var ow = object.offsetWidth;
	var oh = object.offsetHeight;
	var sboxes = document.all.tags("select");
	for (var i=0; i<sboxes.length; i++)
	{
		var node = sboxes[i].parentNode;
		while (node != object && node.tagName != "BODY")
			node = node.parentNode;
		var skip = (node == object);
		if (skip) continue;
		var t = getElementY(sboxes[i]);
		var l = getElementX(sboxes[i]);
		var w = sboxes[i].offsetWidth;
		var h = sboxes[i].offsetHeight;
		var ver = false;
		if (t > ot && t < (ot + oh))
			ver = true;
		else if ((t + h) > ot && (t + h) < (ot + oh))
			ver = true;
		var hor = false;
		if (l > ol && l < (ol + ow))
			hor = true;
		else if ((l + w) > ol && (l + w) < (ol + ow))
			hor = true;
		else if (l < ol && (l + w) > ol)
			hor = true;
		if (true || ver && hor && sboxes[i].style.visibility != "hidden")
			object.sboxes[object.sboxes.length] = sboxes[i];
	}
		
	for (var i=0; i<object.sboxes.length; i++)
		object.sboxes[i].style.visibility = "hidden";
}

function showSelectBoxes(object)
{
	if (!object) return;
	if (!object.sboxes) return;
	for (var i=0; i<object.sboxes.length; i++)
		object.sboxes[i].style.visibility = "";
	object.sboxes = [];
}

function getElementX(object) {return getElementC(object, true)}
function getElementY(object) {return getElementC(object, false)}

function getElementC(element, xAxis)
{
	var initialElement = element;
	var c = 0;

	while (element != null)
	{
		c += (xAxis) ? element.offsetLeft : element.offsetTop;
		if (element.style.position == "absolute")
			break;
		else
			element = element.offsetParent;
	}

	var elementWnd = document.window;
	if (!elementWnd) return c;

	if (!elementWnd.frameElement) return c;

	return c + getElementC(elementWnd.frameElement, xAxis);
}

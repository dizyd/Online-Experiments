Slider input with nicely formatted endpoints

```html
<div class="content-horizontal-space-between">
	<label for="eval_info" class="pull-left content-vertical-center"> no - 0%</label>
    <input type="range" name="eval_info" id="eval_info" min="0" max="100" step="1" class="slider">
    <label class="pull-right content-vertical-center"> yes - 100%</label>
</div>
```


### Query select all elements with specific class

```javascript

  document.querySelectorAll(".some_class");
  
```

### Loop over selected element

```javascript
const all_elements = document.querySelectorAll(".some_class");

all_elements.forEach((i) => {
  i.disabled = true,
});
```

### Add an event listener (needs to be in `run` phase)

```javascript
window.addEventListener('input', updateValue);

function updateValue(e) {  
  input_times.push(e.timeStamp);  
  input_values.push(e.data);
  //debugger
}
```

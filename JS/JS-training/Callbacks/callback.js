/* https://github.com/bgando/functionalJS */
/* Callback Exercises
    Write a function, funcCaller, that takes a func (a function) and an arg (any data type).
    The function returns the func called with arg(as an argument).*/

    var funcCaller = function(func, arg) {
    	return func(arg);
    };

    /*Write a function, firstVal, that takes an array, arr, and a function, func,
    and calls func with the first index of the arr, the index # and the whole array.*/

    var firstVal = function(arr, func) {
    	return func(arr[0], 0, arr);
    };

    /*Change firstVal to work not only with arrays but also objects.
    Since objects are not ordered, you can use any key-value pair on the object.*/

    var firstVal = function(list, func) {
    	if Array.isArray(list) {
    	  return func(list[0], 0, list);
    	} else {
    	  return func(list["foo"], "foo", list);
    	};
    };

    /*  [Extra Credit] Write a function, once, (see: http://underscorejs.org/#once)
    that takes a function and returns a version of that function which can only be called once.
    [Hint: you need a closure] You probably don't want to be able to double charge someone's credit card.
    Here is an example of how to use it:

      var chargeCreditCard = function(num, price){
        //charges credit card for a certain price
      };
      var processPaymentOnce = once(chargeCreditCard);
      processPaymentOnce(123456789012, 200);  */

      var once = function(func) {
      	var called = false;
      	if (!called) {
      		called = true;
      		return func();
      	} else {
      		console.log('Already been called');
      	};
      };

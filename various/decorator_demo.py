# Using decorators

# @deco
# def foo():
#   pass
# This is equivalent to:
# foo = deco(foo) 
#
# A decorator that takes arguments
# @decomaker(deco_args)
# def foo():
#   pass
# This is equivalent to:
# foo = decomaker(deco_args)(foo)
#
# Another example:
# @deco1(deco_args)
# @deco2
# def foo():
# pass
# This is equivalent to:
# foo = deco1(deco_args)(deco2(foo))

def log(func):
    def wrappedFunc():
        print(f"Function name: {func.__name__}")
        return func()
    return wrappedFunc

@log
def foo():
    print("Inside foo()")

foo()

# Output:
# python sample_1.py 
#
# Function name: foo
# Inside foo()

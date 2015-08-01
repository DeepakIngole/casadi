import casadi.*

% SX stuff
x = SX.sym('x');
y = SX.sym('y');
f = cos(x*y)
y = SX.ones(3,2)
f = cos(x*y)


y = SX.sym('y',2,1);
z = MX.sym('z',3);




f = SXFunction('f',{x},{cos(x)})

f.setInput(3,0)

f.evaluate()


disp(f.getOutput())

res = f.getOutput()-DMatrix(cos(3))
assert(iszero(res))


x = SX.sym('x',4);

f = SXFunction('f',{x},{x(2),x(IMatrix(2)),x(2,1),x(IMatrix(2),IMatrix(1)),x(2:2),x(2:2,1)});

f.setInput([1,2,3,4])
f.evaluate()

for i=1:f.nOut()
  res = f.getOutput(i-1)-2;

  assert(res.isZero())

end

flag = false;
try
  x(5);
catch
  flag = true;
end
assert(flag);



flag = false;
try
  x(0);
catch
  flag = true;
end
assert(flag);


x = MX.sym('x',4);

f = MXFunction('f',{x},{x(2),x(IMatrix(2)),x(2,1),x(IMatrix(2),IMatrix(1)),x(2:2),x(2:2,1)});

f.setInput([1,2,3,4])
f.evaluate()

for i=1:f.nOut()
  res = f.getOutput(i-1)-2;

  assert(res.isZero())

end


flag = false;
try
  x(5);
catch
  flag = true;
end
assert(flag);

flag = false;
try
  x(0);
catch
  flag = true;
end
assert(flag);



% Checking stdout

delete 'diary'
diary ON
x = DMatrix.ones(2,2);

x.printDense();

x = SX.sym('x');


ode = SXFunction('ode',daeIn('x',x),daeOut('ode',x));

opts = struct
opts.verbose = true

intg = Integrator('integrator', 'rk',ode,opts);
intg.evaluate();
diary OFF

logged = fileread('diary');

assert(~isempty(strfind(logged,'1')))
assert(~isempty(strfind(logged,'::init')))


clear


x = SX.sym('x',4,5);
dim = size(x);
assert(dim(1)==4)
assert(dim(2)==5)

%nlpErr

warning('error','SWIG:RuntimeError')
msg = '';
try
  nlpIn('foo',SX.sym('x'))
catch err
  msg = err.message;
end

assert(~isempty(strfind(msg,'[x, p]')))

% error message beautification

msg = '';
try
  SXFunction('f',[SX.sym('12')])
catch err
  msg = err.message;
end

assert(~isempty(strfind(msg,'  SXFunction(char,{SX} ,{SX} ,Dict)')))
assert(~isempty(strfind(msg,'You have: char, SX')))


DMatrix(1)+MX(1)
MX(1)+DMatrix(1)

MX.sym('x',5,5)*3
MX.sym('x',5,5).*3

a = SX.sym('a');
b = substitute({sin(a), cos(a)}, {a},{a+3});
b{1}
b{2}

veccat(MX.sym('x',2,3),MX.sym('x',4,5))
length(MX.sym('x',4,1))
assert(length(MX.sym('x',4,1))==4)
assert(length(MX.sym('x',1,3))==3)
assert(length(MX.sym('x',4,5))==5)

[n,m] = size(MX.sym('x',4,5));
assert(n==4)
assert(m==5)

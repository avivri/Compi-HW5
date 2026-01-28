declare i32 @printf(i8*, ...)
declare void @exit(i32)
@.int_specifier = constant [4 x i8] c"%d\0A\00"
@.str_specifier = constant [4 x i8] c"%s\0A\00"
define void @printi(i32) {
  %spec_ptr = getelementptr [4 x i8], [4 x i8]* @.int_specifier, i32 0, i32 0
  call i32 (i8*, ...) @printf(i8* %spec_ptr, i32 %0)
  ret void
}
define void @print(i8*) {
  %spec_ptr = getelementptr [4 x i8], [4 x i8]* @.str_specifier, i32 0, i32 0
  call i32 (i8*, ...) @printf(i8* %spec_ptr, i8* %0)
  ret void
}
@.str_div_err = constant [23 x i8] c"Error division by zero\00"
@.str1 = constant [4 x i8] c"f1!\00"
@.str2 = constant [4 x i8] c"f2!\00"
@.str3 = constant [4 x i8] c"f3!\00"
@.str4 = constant [14 x i8] c"call me maybe\00"

  define i32 @f1(i32) {
  entry:
  %t1 = alloca i32
  store i32 %0, i32* %t1
  %t2 = getelementptr [4 x i8], [4 x i8]* @.str1, i32 0, i32 0
  call void @print(i8* %t2)
  %t3 = load i32, i32* %t1
  ret i32 %t3
  }
  
  define i8 @f2(i8) {
  entry:
  %t4 = alloca i8
  store i8 %0, i8* %t4
  %t5 = getelementptr [4 x i8], [4 x i8]* @.str2, i32 0, i32 0
  call void @print(i8* %t5)
  }
  
  define i1 @f3(i1) {
  entry:
  %t6 = alloca i1
  store i1 %0, i1* %t6
  %t7 = getelementptr [4 x i8], [4 x i8]* @.str3, i32 0, i32 0
  call void @print(i8* %t7)
  }
  
  define void @callMe(i32, i32, i8, i1, i1, i8, i32, i1) {
  entry:
  %t8 = alloca i32
  store i32 %0, i32* %t8
  %t9 = alloca i32
  store i32 %1, i32* %t9
  %t10 = alloca i8
  store i8 %2, i8* %t10
  %t11 = alloca i1
  store i1 %3, i1* %t11
  %t12 = alloca i1
  store i1 %4, i1* %t12
  %t13 = alloca i8
  store i8 %5, i8* %t13
  %t14 = alloca i32
  store i32 %6, i32* %t14
  %t15 = alloca i1
  store i1 %7, i1* %t15
  %t16 = getelementptr [14 x i8], [14 x i8]* @.str4, i32 0, i32 0
  call void @print(i8* %t16)
  }
  
  define void @main() {
  entry:
  %t17 = add i32 2, 0
  %t18 = call i32 @f1(i32 %t17)
  %t19 = add i8 4, 0
  %t20 = call i8 @f2(i8 %t19)
  %t21 = add i8 5, 0
  %t22 = call i8 @f2(i8 %t21)
  %t23 = add i1 1, 0
  %t24 = call i1 @f3(i1 %t23)
  %t25 = add i1 0, 0
  %t26 = call i1 @f3(i1 %t25)
  %t27 = add i8 3, 0
  %t28 = call i8 @f2(i8 %t27)
  %t29 = add i32 22, 0
  %t30 = call i32 @f1(i32 %t29)
  %t31 = add i1 0, 0
  %t32 = call i1 @f3(i1 %t31)
  %t33 = zext i8 %t20 to i32
  call void @callMe(i32 %t18, i32 %t33, i8 %t22, i1 %t24, i1 %t26, i8 %t28, i32 %t30, i1 %t32)
  }
  

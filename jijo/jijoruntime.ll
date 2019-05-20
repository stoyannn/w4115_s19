; ModuleID = './jijoruntime.c'
source_filename = "./jijoruntime.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }
%struct.__va_list_tag = type { i32, i32, i8*, i8* }
%struct._value = type { i8, double }
%struct._composite = type { i32, %struct._element* }
%struct._element = type { i32, %struct._value }

@.str = private unnamed_addr constant [5 x i8] c"void\00", align 1
@.str.1 = private unnamed_addr constant [5 x i8] c"null\00", align 1
@.str.2 = private unnamed_addr constant [8 x i8] c"boolean\00", align 1
@.str.3 = private unnamed_addr constant [7 x i8] c"number\00", align 1
@.str.4 = private unnamed_addr constant [7 x i8] c"string\00", align 1
@.str.5 = private unnamed_addr constant [7 x i8] c"object\00", align 1
@.str.6 = private unnamed_addr constant [6 x i8] c"array\00", align 1
@.str.7 = private unnamed_addr constant [8 x i8] c"unknown\00", align 1
@stderr = external global %struct._IO_FILE*, align 8
@.str.8 = private unnamed_addr constant [11 x i8] c"ERROR %d: \00", align 1
@.str.9 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.10 = private unnamed_addr constant [4 x i8] c"%s\0A\00", align 1
@.str.11 = private unnamed_addr constant [24 x i8] c"memory allocation error\00", align 1
@.str.12 = private unnamed_addr constant [30 x i8] c"wrong operand types: %s %s %s\00", align 1
@.str.13 = private unnamed_addr constant [29 x i8] c"wrong operand type: %s %s %s\00", align 1
@.str.14 = private unnamed_addr constant [2 x i8] c"+\00", align 1
@.str.15 = private unnamed_addr constant [2 x i8] c"-\00", align 1
@.str.16 = private unnamed_addr constant [2 x i8] c"*\00", align 1
@.str.17 = private unnamed_addr constant [2 x i8] c"/\00", align 1
@.str.18 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@.str.19 = private unnamed_addr constant [2 x i8] c"<\00", align 1
@.str.20 = private unnamed_addr constant [3 x i8] c"<=\00", align 1
@.str.21 = private unnamed_addr constant [2 x i8] c">\00", align 1
@.str.22 = private unnamed_addr constant [3 x i8] c">=\00", align 1
@.str.23 = private unnamed_addr constant [3 x i8] c"&&\00", align 1
@.str.24 = private unnamed_addr constant [3 x i8] c"||\00", align 1
@.str.25 = private unnamed_addr constant [2 x i8] c"!\00", align 1
@.str.26 = private unnamed_addr constant [29 x i8] c"wrong type for condition: %s\00", align 1
@.str.27 = private unnamed_addr constant [29 x i8] c"wrong type for composite: %s\00", align 1
@.str.28 = private unnamed_addr constant [26 x i8] c"wrong type for string: %s\00", align 1
@.str.29 = private unnamed_addr constant [2 x i8] c"[\00", align 1
@.str.30 = private unnamed_addr constant [2 x i8] c".\00", align 1
@.str.31 = private unnamed_addr constant [4 x i8] c"[?]\00", align 1
@.str.32 = private unnamed_addr constant [2 x i8] c"^\00", align 1
@stdout = external global %struct._IO_FILE*, align 8
@.str.33 = private unnamed_addr constant [3 x i8] c"%s\00", align 1
@.str.34 = private unnamed_addr constant [5 x i8] c"true\00", align 1
@.str.35 = private unnamed_addr constant [6 x i8] c"false\00", align 1
@.str.36 = private unnamed_addr constant [4 x i8] c"%ld\00", align 1
@.str.37 = private unnamed_addr constant [3 x i8] c"%f\00", align 1
@.str.38 = private unnamed_addr constant [3 x i8] c"{ \00", align 1
@.str.39 = private unnamed_addr constant [3 x i8] c" }\00", align 1
@.str.40 = private unnamed_addr constant [3 x i8] c"[ \00", align 1
@.str.41 = private unnamed_addr constant [3 x i8] c" ]\00", align 1
@.str.42 = private unnamed_addr constant [22 x i8] c"unknown type code: %d\00", align 1
@.str.43 = private unnamed_addr constant [7 x i8] c", %d: \00", align 1
@.str.44 = private unnamed_addr constant [5 x i8] c"%d: \00", align 1
@.str.45 = private unnamed_addr constant [12 x i8] c"unspecified\00", align 1
@.str.46 = private unnamed_addr constant [22 x i8] c"assertion failure: %s\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i8* @_type_str(i8 zeroext) #0 {
  %2 = alloca i8*, align 8
  %3 = alloca i8, align 1
  store i8 %0, i8* %3, align 1
  %4 = load i8, i8* %3, align 1
  %5 = zext i8 %4 to i32
  switch i32 %5, label %13 [
    i32 0, label %6
    i32 1, label %7
    i32 2, label %8
    i32 3, label %9
    i32 4, label %10
    i32 5, label %11
    i32 6, label %12
  ]

; <label>:6:                                      ; preds = %1
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0), i8** %2, align 8
  br label %14

; <label>:7:                                      ; preds = %1
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1, i32 0, i32 0), i8** %2, align 8
  br label %14

; <label>:8:                                      ; preds = %1
  store i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.2, i32 0, i32 0), i8** %2, align 8
  br label %14

; <label>:9:                                      ; preds = %1
  store i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.3, i32 0, i32 0), i8** %2, align 8
  br label %14

; <label>:10:                                     ; preds = %1
  store i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.4, i32 0, i32 0), i8** %2, align 8
  br label %14

; <label>:11:                                     ; preds = %1
  store i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.5, i32 0, i32 0), i8** %2, align 8
  br label %14

; <label>:12:                                     ; preds = %1
  store i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.6, i32 0, i32 0), i8** %2, align 8
  br label %14

; <label>:13:                                     ; preds = %1
  store i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.7, i32 0, i32 0), i8** %2, align 8
  br label %14

; <label>:14:                                     ; preds = %13, %12, %11, %10, %9, %8, %7, %6
  %15 = load i8*, i8** %2, align 8
  ret i8* %15
}

; Function Attrs: noinline nounwind optnone uwtable
define void @_fatal(i32, i8*, ...) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i8*, align 8
  %5 = alloca [1 x %struct.__va_list_tag], align 16
  %6 = alloca [128 x i8*], align 16
  %7 = alloca i32, align 4
  %8 = alloca i8**, align 8
  %9 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  store i8* %1, i8** %4, align 8
  %10 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %11 = load i32, i32* %3, align 4
  %12 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %10, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.8, i32 0, i32 0), i32 %11)
  %13 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %5, i32 0, i32 0
  %14 = bitcast %struct.__va_list_tag* %13 to i8*
  call void @llvm.va_start(i8* %14)
  %15 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %16 = load i8*, i8** %4, align 8
  %17 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %5, i32 0, i32 0
  %18 = call i32 @vfprintf(%struct._IO_FILE* %15, i8* %16, %struct.__va_list_tag* %17)
  %19 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %5, i32 0, i32 0
  %20 = bitcast %struct.__va_list_tag* %19 to i8*
  call void @llvm.va_end(i8* %20)
  %21 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %22 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %21, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.9, i32 0, i32 0))
  %23 = getelementptr inbounds [128 x i8*], [128 x i8*]* %6, i32 0, i32 0
  %24 = call i32 @backtrace(i8** %23, i32 128)
  store i32 %24, i32* %7, align 4
  %25 = getelementptr inbounds [128 x i8*], [128 x i8*]* %6, i32 0, i32 0
  %26 = load i32, i32* %7, align 4
  %27 = call i8** @backtrace_symbols(i8** %25, i32 %26) #2
  store i8** %27, i8*** %8, align 8
  store i32 0, i32* %9, align 4
  br label %28

; <label>:28:                                     ; preds = %40, %2
  %29 = load i32, i32* %9, align 4
  %30 = load i32, i32* %7, align 4
  %31 = icmp slt i32 %29, %30
  br i1 %31, label %32, label %43

; <label>:32:                                     ; preds = %28
  %33 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %34 = load i8**, i8*** %8, align 8
  %35 = load i32, i32* %9, align 4
  %36 = sext i32 %35 to i64
  %37 = getelementptr inbounds i8*, i8** %34, i64 %36
  %38 = load i8*, i8** %37, align 8
  %39 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %33, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.10, i32 0, i32 0), i8* %38)
  br label %40

; <label>:40:                                     ; preds = %32
  %41 = load i32, i32* %9, align 4
  %42 = add nsw i32 %41, 1
  store i32 %42, i32* %9, align 4
  br label %28

; <label>:43:                                     ; preds = %28
  %44 = load i8**, i8*** %8, align 8
  %45 = bitcast i8** %44 to i8*
  call void @free(i8* %45) #2
  %46 = load i32, i32* %3, align 4
  call void @exit(i32 %46) #8
  unreachable
                                                  ; No predecessors!
  ret void
}

declare i32 @fprintf(%struct._IO_FILE*, i8*, ...) #1

; Function Attrs: nounwind
declare void @llvm.va_start(i8*) #2

declare i32 @vfprintf(%struct._IO_FILE*, i8*, %struct.__va_list_tag*) #1

; Function Attrs: nounwind
declare void @llvm.va_end(i8*) #2

declare i32 @backtrace(i8**, i32) #1

; Function Attrs: nounwind
declare i8** @backtrace_symbols(i8**, i32) #3

; Function Attrs: nounwind
declare void @free(i8*) #3

; Function Attrs: noreturn nounwind
declare void @exit(i32) #4

; Function Attrs: noinline nounwind optnone uwtable
define void @_check_alloc(i8*) #0 {
  %2 = alloca i8*, align 8
  store i8* %0, i8** %2, align 8
  %3 = load i8*, i8** %2, align 8
  %4 = icmp eq i8* %3, null
  br i1 %4, label %5, label %6

; <label>:5:                                      ; preds = %1
  call void (i32, i8*, ...) @_fatal(i32 103, i8* getelementptr inbounds ([24 x i8], [24 x i8]* @.str.11, i32 0, i32 0))
  br label %6

; <label>:6:                                      ; preds = %5, %1
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define void @_binop_typecheck(i8*, i8, double, i8 zeroext, i8, double, i8 zeroext) #0 {
  %8 = alloca %struct._value, align 8
  %9 = alloca %struct._value, align 8
  %10 = alloca i8*, align 8
  %11 = alloca i8, align 1
  %12 = alloca i8, align 1
  %13 = bitcast %struct._value* %8 to { i8, double }*
  %14 = getelementptr inbounds { i8, double }, { i8, double }* %13, i32 0, i32 0
  store i8 %1, i8* %14, align 8
  %15 = getelementptr inbounds { i8, double }, { i8, double }* %13, i32 0, i32 1
  store double %2, double* %15, align 8
  %16 = bitcast %struct._value* %9 to { i8, double }*
  %17 = getelementptr inbounds { i8, double }, { i8, double }* %16, i32 0, i32 0
  store i8 %4, i8* %17, align 8
  %18 = getelementptr inbounds { i8, double }, { i8, double }* %16, i32 0, i32 1
  store double %5, double* %18, align 8
  store i8* %0, i8** %10, align 8
  store i8 %3, i8* %11, align 1
  store i8 %6, i8* %12, align 1
  %19 = getelementptr inbounds %struct._value, %struct._value* %8, i32 0, i32 0
  %20 = load i8, i8* %19, align 8
  %21 = zext i8 %20 to i32
  %22 = load i8, i8* %11, align 1
  %23 = zext i8 %22 to i32
  %24 = icmp ne i32 %21, %23
  br i1 %24, label %32, label %25

; <label>:25:                                     ; preds = %7
  %26 = getelementptr inbounds %struct._value, %struct._value* %9, i32 0, i32 0
  %27 = load i8, i8* %26, align 8
  %28 = zext i8 %27 to i32
  %29 = load i8, i8* %12, align 1
  %30 = zext i8 %29 to i32
  %31 = icmp ne i32 %28, %30
  br i1 %31, label %32, label %40

; <label>:32:                                     ; preds = %25, %7
  %33 = getelementptr inbounds %struct._value, %struct._value* %8, i32 0, i32 0
  %34 = load i8, i8* %33, align 8
  %35 = call i8* @_type_str(i8 zeroext %34)
  %36 = load i8*, i8** %10, align 8
  %37 = getelementptr inbounds %struct._value, %struct._value* %9, i32 0, i32 0
  %38 = load i8, i8* %37, align 8
  %39 = call i8* @_type_str(i8 zeroext %38)
  call void (i32, i8*, ...) @_fatal(i32 101, i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.12, i32 0, i32 0), i8* %35, i8* %36, i8* %39)
  br label %40

; <label>:40:                                     ; preds = %32, %25
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define void @_unop_typecheck(i8*, i8, double, i8 zeroext, i8*) #0 {
  %6 = alloca %struct._value, align 8
  %7 = alloca i8*, align 8
  %8 = alloca i8, align 1
  %9 = alloca i8*, align 8
  %10 = bitcast %struct._value* %6 to { i8, double }*
  %11 = getelementptr inbounds { i8, double }, { i8, double }* %10, i32 0, i32 0
  store i8 %1, i8* %11, align 8
  %12 = getelementptr inbounds { i8, double }, { i8, double }* %10, i32 0, i32 1
  store double %2, double* %12, align 8
  store i8* %0, i8** %7, align 8
  store i8 %3, i8* %8, align 1
  store i8* %4, i8** %9, align 8
  %13 = getelementptr inbounds %struct._value, %struct._value* %6, i32 0, i32 0
  %14 = load i8, i8* %13, align 8
  %15 = zext i8 %14 to i32
  %16 = load i8, i8* %8, align 1
  %17 = zext i8 %16 to i32
  %18 = icmp ne i32 %15, %17
  br i1 %18, label %19, label %25

; <label>:19:                                     ; preds = %5
  %20 = load i8*, i8** %7, align 8
  %21 = getelementptr inbounds %struct._value, %struct._value* %6, i32 0, i32 0
  %22 = load i8, i8* %21, align 8
  %23 = call i8* @_type_str(i8 zeroext %22)
  %24 = load i8*, i8** %9, align 8
  call void (i32, i8*, ...) @_fatal(i32 101, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @.str.13, i32 0, i32 0), i8* %20, i8* %23, i8* %24)
  br label %25

; <label>:25:                                     ; preds = %19, %5
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define { i8, double } @_binop_plus(i8, double, i8, double) #0 {
  %5 = alloca %struct._value, align 8
  %6 = alloca %struct._value, align 8
  %7 = alloca %struct._value, align 8
  %8 = bitcast %struct._value* %6 to { i8, double }*
  %9 = getelementptr inbounds { i8, double }, { i8, double }* %8, i32 0, i32 0
  store i8 %0, i8* %9, align 8
  %10 = getelementptr inbounds { i8, double }, { i8, double }* %8, i32 0, i32 1
  store double %1, double* %10, align 8
  %11 = bitcast %struct._value* %7 to { i8, double }*
  %12 = getelementptr inbounds { i8, double }, { i8, double }* %11, i32 0, i32 0
  store i8 %2, i8* %12, align 8
  %13 = getelementptr inbounds { i8, double }, { i8, double }* %11, i32 0, i32 1
  store double %3, double* %13, align 8
  %14 = bitcast %struct._value* %6 to { i8, double }*
  %15 = getelementptr inbounds { i8, double }, { i8, double }* %14, i32 0, i32 0
  %16 = load i8, i8* %15, align 8
  %17 = getelementptr inbounds { i8, double }, { i8, double }* %14, i32 0, i32 1
  %18 = load double, double* %17, align 8
  %19 = bitcast %struct._value* %7 to { i8, double }*
  %20 = getelementptr inbounds { i8, double }, { i8, double }* %19, i32 0, i32 0
  %21 = load i8, i8* %20, align 8
  %22 = getelementptr inbounds { i8, double }, { i8, double }* %19, i32 0, i32 1
  %23 = load double, double* %22, align 8
  call void @_binop_typecheck(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.14, i32 0, i32 0), i8 %16, double %18, i8 zeroext 3, i8 %21, double %23, i8 zeroext 3)
  %24 = getelementptr inbounds %struct._value, %struct._value* %5, i32 0, i32 0
  %25 = getelementptr inbounds %struct._value, %struct._value* %6, i32 0, i32 0
  %26 = load i8, i8* %25, align 8
  store i8 %26, i8* %24, align 8
  %27 = getelementptr inbounds %struct._value, %struct._value* %5, i32 0, i32 1
  %28 = getelementptr inbounds %struct._value, %struct._value* %6, i32 0, i32 1
  %29 = load double, double* %28, align 8
  %30 = getelementptr inbounds %struct._value, %struct._value* %7, i32 0, i32 1
  %31 = load double, double* %30, align 8
  %32 = fadd double %29, %31
  store double %32, double* %27, align 8
  %33 = bitcast %struct._value* %5 to { i8, double }*
  %34 = load { i8, double }, { i8, double }* %33, align 8
  ret { i8, double } %34
}

; Function Attrs: noinline nounwind optnone uwtable
define { i8, double } @_binop_minus(i8, double, i8, double) #0 {
  %5 = alloca %struct._value, align 8
  %6 = alloca %struct._value, align 8
  %7 = alloca %struct._value, align 8
  %8 = bitcast %struct._value* %6 to { i8, double }*
  %9 = getelementptr inbounds { i8, double }, { i8, double }* %8, i32 0, i32 0
  store i8 %0, i8* %9, align 8
  %10 = getelementptr inbounds { i8, double }, { i8, double }* %8, i32 0, i32 1
  store double %1, double* %10, align 8
  %11 = bitcast %struct._value* %7 to { i8, double }*
  %12 = getelementptr inbounds { i8, double }, { i8, double }* %11, i32 0, i32 0
  store i8 %2, i8* %12, align 8
  %13 = getelementptr inbounds { i8, double }, { i8, double }* %11, i32 0, i32 1
  store double %3, double* %13, align 8
  %14 = bitcast %struct._value* %6 to { i8, double }*
  %15 = getelementptr inbounds { i8, double }, { i8, double }* %14, i32 0, i32 0
  %16 = load i8, i8* %15, align 8
  %17 = getelementptr inbounds { i8, double }, { i8, double }* %14, i32 0, i32 1
  %18 = load double, double* %17, align 8
  %19 = bitcast %struct._value* %7 to { i8, double }*
  %20 = getelementptr inbounds { i8, double }, { i8, double }* %19, i32 0, i32 0
  %21 = load i8, i8* %20, align 8
  %22 = getelementptr inbounds { i8, double }, { i8, double }* %19, i32 0, i32 1
  %23 = load double, double* %22, align 8
  call void @_binop_typecheck(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.15, i32 0, i32 0), i8 %16, double %18, i8 zeroext 3, i8 %21, double %23, i8 zeroext 3)
  %24 = getelementptr inbounds %struct._value, %struct._value* %5, i32 0, i32 0
  %25 = getelementptr inbounds %struct._value, %struct._value* %6, i32 0, i32 0
  %26 = load i8, i8* %25, align 8
  store i8 %26, i8* %24, align 8
  %27 = getelementptr inbounds %struct._value, %struct._value* %5, i32 0, i32 1
  %28 = getelementptr inbounds %struct._value, %struct._value* %6, i32 0, i32 1
  %29 = load double, double* %28, align 8
  %30 = getelementptr inbounds %struct._value, %struct._value* %7, i32 0, i32 1
  %31 = load double, double* %30, align 8
  %32 = fsub double %29, %31
  store double %32, double* %27, align 8
  %33 = bitcast %struct._value* %5 to { i8, double }*
  %34 = load { i8, double }, { i8, double }* %33, align 8
  ret { i8, double } %34
}

; Function Attrs: noinline nounwind optnone uwtable
define { i8, double } @_binop_mult(i8, double, i8, double) #0 {
  %5 = alloca %struct._value, align 8
  %6 = alloca %struct._value, align 8
  %7 = alloca %struct._value, align 8
  %8 = bitcast %struct._value* %6 to { i8, double }*
  %9 = getelementptr inbounds { i8, double }, { i8, double }* %8, i32 0, i32 0
  store i8 %0, i8* %9, align 8
  %10 = getelementptr inbounds { i8, double }, { i8, double }* %8, i32 0, i32 1
  store double %1, double* %10, align 8
  %11 = bitcast %struct._value* %7 to { i8, double }*
  %12 = getelementptr inbounds { i8, double }, { i8, double }* %11, i32 0, i32 0
  store i8 %2, i8* %12, align 8
  %13 = getelementptr inbounds { i8, double }, { i8, double }* %11, i32 0, i32 1
  store double %3, double* %13, align 8
  %14 = bitcast %struct._value* %6 to { i8, double }*
  %15 = getelementptr inbounds { i8, double }, { i8, double }* %14, i32 0, i32 0
  %16 = load i8, i8* %15, align 8
  %17 = getelementptr inbounds { i8, double }, { i8, double }* %14, i32 0, i32 1
  %18 = load double, double* %17, align 8
  %19 = bitcast %struct._value* %7 to { i8, double }*
  %20 = getelementptr inbounds { i8, double }, { i8, double }* %19, i32 0, i32 0
  %21 = load i8, i8* %20, align 8
  %22 = getelementptr inbounds { i8, double }, { i8, double }* %19, i32 0, i32 1
  %23 = load double, double* %22, align 8
  call void @_binop_typecheck(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.16, i32 0, i32 0), i8 %16, double %18, i8 zeroext 3, i8 %21, double %23, i8 zeroext 3)
  %24 = getelementptr inbounds %struct._value, %struct._value* %5, i32 0, i32 0
  %25 = getelementptr inbounds %struct._value, %struct._value* %6, i32 0, i32 0
  %26 = load i8, i8* %25, align 8
  store i8 %26, i8* %24, align 8
  %27 = getelementptr inbounds %struct._value, %struct._value* %5, i32 0, i32 1
  %28 = getelementptr inbounds %struct._value, %struct._value* %6, i32 0, i32 1
  %29 = load double, double* %28, align 8
  %30 = getelementptr inbounds %struct._value, %struct._value* %7, i32 0, i32 1
  %31 = load double, double* %30, align 8
  %32 = fmul double %29, %31
  store double %32, double* %27, align 8
  %33 = bitcast %struct._value* %5 to { i8, double }*
  %34 = load { i8, double }, { i8, double }* %33, align 8
  ret { i8, double } %34
}

; Function Attrs: noinline nounwind optnone uwtable
define { i8, double } @_binop_div(i8, double, i8, double) #0 {
  %5 = alloca %struct._value, align 8
  %6 = alloca %struct._value, align 8
  %7 = alloca %struct._value, align 8
  %8 = bitcast %struct._value* %6 to { i8, double }*
  %9 = getelementptr inbounds { i8, double }, { i8, double }* %8, i32 0, i32 0
  store i8 %0, i8* %9, align 8
  %10 = getelementptr inbounds { i8, double }, { i8, double }* %8, i32 0, i32 1
  store double %1, double* %10, align 8
  %11 = bitcast %struct._value* %7 to { i8, double }*
  %12 = getelementptr inbounds { i8, double }, { i8, double }* %11, i32 0, i32 0
  store i8 %2, i8* %12, align 8
  %13 = getelementptr inbounds { i8, double }, { i8, double }* %11, i32 0, i32 1
  store double %3, double* %13, align 8
  %14 = bitcast %struct._value* %6 to { i8, double }*
  %15 = getelementptr inbounds { i8, double }, { i8, double }* %14, i32 0, i32 0
  %16 = load i8, i8* %15, align 8
  %17 = getelementptr inbounds { i8, double }, { i8, double }* %14, i32 0, i32 1
  %18 = load double, double* %17, align 8
  %19 = bitcast %struct._value* %7 to { i8, double }*
  %20 = getelementptr inbounds { i8, double }, { i8, double }* %19, i32 0, i32 0
  %21 = load i8, i8* %20, align 8
  %22 = getelementptr inbounds { i8, double }, { i8, double }* %19, i32 0, i32 1
  %23 = load double, double* %22, align 8
  call void @_binop_typecheck(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.17, i32 0, i32 0), i8 %16, double %18, i8 zeroext 3, i8 %21, double %23, i8 zeroext 3)
  %24 = getelementptr inbounds %struct._value, %struct._value* %5, i32 0, i32 0
  %25 = getelementptr inbounds %struct._value, %struct._value* %6, i32 0, i32 0
  %26 = load i8, i8* %25, align 8
  store i8 %26, i8* %24, align 8
  %27 = getelementptr inbounds %struct._value, %struct._value* %5, i32 0, i32 1
  %28 = getelementptr inbounds %struct._value, %struct._value* %6, i32 0, i32 1
  %29 = load double, double* %28, align 8
  %30 = getelementptr inbounds %struct._value, %struct._value* %7, i32 0, i32 1
  %31 = load double, double* %30, align 8
  %32 = fdiv double %29, %31
  store double %32, double* %27, align 8
  %33 = bitcast %struct._value* %5 to { i8, double }*
  %34 = load { i8, double }, { i8, double }* %33, align 8
  ret { i8, double } %34
}

; Function Attrs: noinline nounwind optnone uwtable
define { i8, double } @_unop_uminus(i8, double) #0 {
  %3 = alloca %struct._value, align 8
  %4 = alloca %struct._value, align 8
  %5 = bitcast %struct._value* %4 to { i8, double }*
  %6 = getelementptr inbounds { i8, double }, { i8, double }* %5, i32 0, i32 0
  store i8 %0, i8* %6, align 8
  %7 = getelementptr inbounds { i8, double }, { i8, double }* %5, i32 0, i32 1
  store double %1, double* %7, align 8
  %8 = bitcast %struct._value* %4 to { i8, double }*
  %9 = getelementptr inbounds { i8, double }, { i8, double }* %8, i32 0, i32 0
  %10 = load i8, i8* %9, align 8
  %11 = getelementptr inbounds { i8, double }, { i8, double }* %8, i32 0, i32 1
  %12 = load double, double* %11, align 8
  call void @_unop_typecheck(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.15, i32 0, i32 0), i8 %10, double %12, i8 zeroext 3, i8* getelementptr inbounds ([1 x i8], [1 x i8]* @.str.18, i32 0, i32 0))
  %13 = getelementptr inbounds %struct._value, %struct._value* %3, i32 0, i32 0
  %14 = getelementptr inbounds %struct._value, %struct._value* %4, i32 0, i32 0
  %15 = load i8, i8* %14, align 8
  store i8 %15, i8* %13, align 8
  %16 = getelementptr inbounds %struct._value, %struct._value* %3, i32 0, i32 1
  %17 = getelementptr inbounds %struct._value, %struct._value* %4, i32 0, i32 1
  %18 = load double, double* %17, align 8
  %19 = fmul double -1.000000e+00, %18
  store double %19, double* %16, align 8
  %20 = bitcast %struct._value* %3 to { i8, double }*
  %21 = load { i8, double }, { i8, double }* %20, align 8
  ret { i8, double } %21
}

; Function Attrs: noinline nounwind optnone uwtable
define { i8, double } @_binop_equal(i8, double, i8, double) #0 {
  %5 = alloca %struct._value, align 8
  %6 = alloca %struct._value, align 8
  %7 = alloca %struct._value, align 8
  %8 = bitcast %struct._value* %6 to { i8, double }*
  %9 = getelementptr inbounds { i8, double }, { i8, double }* %8, i32 0, i32 0
  store i8 %0, i8* %9, align 8
  %10 = getelementptr inbounds { i8, double }, { i8, double }* %8, i32 0, i32 1
  store double %1, double* %10, align 8
  %11 = bitcast %struct._value* %7 to { i8, double }*
  %12 = getelementptr inbounds { i8, double }, { i8, double }* %11, i32 0, i32 0
  store i8 %2, i8* %12, align 8
  %13 = getelementptr inbounds { i8, double }, { i8, double }* %11, i32 0, i32 1
  store double %3, double* %13, align 8
  %14 = getelementptr inbounds %struct._value, %struct._value* %6, i32 0, i32 0
  %15 = load i8, i8* %14, align 8
  %16 = zext i8 %15 to i32
  %17 = getelementptr inbounds %struct._value, %struct._value* %7, i32 0, i32 0
  %18 = load i8, i8* %17, align 8
  %19 = zext i8 %18 to i32
  %20 = icmp ne i32 %16, %19
  br i1 %20, label %21, label %24

; <label>:21:                                     ; preds = %4
  %22 = getelementptr inbounds %struct._value, %struct._value* %5, i32 0, i32 0
  store i8 2, i8* %22, align 8
  %23 = getelementptr inbounds %struct._value, %struct._value* %5, i32 0, i32 1
  store double 0.000000e+00, double* %23, align 8
  br label %66

; <label>:24:                                     ; preds = %4
  %25 = getelementptr inbounds %struct._value, %struct._value* %6, i32 0, i32 0
  %26 = load i8, i8* %25, align 8
  %27 = zext i8 %26 to i32
  %28 = icmp eq i32 %27, 0
  br i1 %28, label %34, label %29

; <label>:29:                                     ; preds = %24
  %30 = getelementptr inbounds %struct._value, %struct._value* %6, i32 0, i32 0
  %31 = load i8, i8* %30, align 8
  %32 = zext i8 %31 to i32
  %33 = icmp eq i32 %32, 1
  br i1 %33, label %34, label %37

; <label>:34:                                     ; preds = %29, %24
  %35 = getelementptr inbounds %struct._value, %struct._value* %5, i32 0, i32 0
  store i8 2, i8* %35, align 8
  %36 = getelementptr inbounds %struct._value, %struct._value* %5, i32 0, i32 1
  store double 1.000000e+00, double* %36, align 8
  br label %66

; <label>:37:                                     ; preds = %29
  %38 = getelementptr inbounds %struct._value, %struct._value* %6, i32 0, i32 0
  %39 = load i8, i8* %38, align 8
  %40 = zext i8 %39 to i32
  %41 = icmp eq i32 %40, 2
  br i1 %41, label %42, label %56

; <label>:42:                                     ; preds = %37
  %43 = getelementptr inbounds %struct._value, %struct._value* %5, i32 0, i32 0
  store i8 2, i8* %43, align 8
  %44 = getelementptr inbounds %struct._value, %struct._value* %5, i32 0, i32 1
  %45 = getelementptr inbounds %struct._value, %struct._value* %6, i32 0, i32 1
  %46 = load double, double* %45, align 8
  %47 = fcmp une double %46, 0.000000e+00
  %48 = zext i1 %47 to i32
  %49 = getelementptr inbounds %struct._value, %struct._value* %7, i32 0, i32 1
  %50 = load double, double* %49, align 8
  %51 = fcmp une double %50, 0.000000e+00
  %52 = zext i1 %51 to i32
  %53 = icmp eq i32 %48, %52
  %54 = zext i1 %53 to i64
  %55 = select i1 %53, double 1.000000e+00, double 0.000000e+00
  store double %55, double* %44, align 8
  br label %66

; <label>:56:                                     ; preds = %37
  %57 = getelementptr inbounds %struct._value, %struct._value* %5, i32 0, i32 0
  store i8 2, i8* %57, align 8
  %58 = getelementptr inbounds %struct._value, %struct._value* %5, i32 0, i32 1
  %59 = getelementptr inbounds %struct._value, %struct._value* %6, i32 0, i32 1
  %60 = load double, double* %59, align 8
  %61 = getelementptr inbounds %struct._value, %struct._value* %7, i32 0, i32 1
  %62 = load double, double* %61, align 8
  %63 = fcmp oeq double %60, %62
  %64 = zext i1 %63 to i64
  %65 = select i1 %63, double 1.000000e+00, double 0.000000e+00
  store double %65, double* %58, align 8
  br label %66

; <label>:66:                                     ; preds = %56, %42, %34, %21
  %67 = bitcast %struct._value* %5 to { i8, double }*
  %68 = load { i8, double }, { i8, double }* %67, align 8
  ret { i8, double } %68
}

; Function Attrs: noinline nounwind optnone uwtable
define { i8, double } @_binop_nequal(i8, double, i8, double) #0 {
  %5 = alloca %struct._value, align 8
  %6 = alloca %struct._value, align 8
  %7 = alloca %struct._value, align 8
  %8 = alloca %struct._value, align 8
  %9 = bitcast %struct._value* %6 to { i8, double }*
  %10 = getelementptr inbounds { i8, double }, { i8, double }* %9, i32 0, i32 0
  store i8 %0, i8* %10, align 8
  %11 = getelementptr inbounds { i8, double }, { i8, double }* %9, i32 0, i32 1
  store double %1, double* %11, align 8
  %12 = bitcast %struct._value* %7 to { i8, double }*
  %13 = getelementptr inbounds { i8, double }, { i8, double }* %12, i32 0, i32 0
  store i8 %2, i8* %13, align 8
  %14 = getelementptr inbounds { i8, double }, { i8, double }* %12, i32 0, i32 1
  store double %3, double* %14, align 8
  %15 = bitcast %struct._value* %6 to { i8, double }*
  %16 = getelementptr inbounds { i8, double }, { i8, double }* %15, i32 0, i32 0
  %17 = load i8, i8* %16, align 8
  %18 = getelementptr inbounds { i8, double }, { i8, double }* %15, i32 0, i32 1
  %19 = load double, double* %18, align 8
  %20 = bitcast %struct._value* %7 to { i8, double }*
  %21 = getelementptr inbounds { i8, double }, { i8, double }* %20, i32 0, i32 0
  %22 = load i8, i8* %21, align 8
  %23 = getelementptr inbounds { i8, double }, { i8, double }* %20, i32 0, i32 1
  %24 = load double, double* %23, align 8
  %25 = call { i8, double } @_binop_equal(i8 %17, double %19, i8 %22, double %24)
  %26 = bitcast %struct._value* %8 to { i8, double }*
  %27 = getelementptr inbounds { i8, double }, { i8, double }* %26, i32 0, i32 0
  %28 = extractvalue { i8, double } %25, 0
  store i8 %28, i8* %27, align 8
  %29 = getelementptr inbounds { i8, double }, { i8, double }* %26, i32 0, i32 1
  %30 = extractvalue { i8, double } %25, 1
  store double %30, double* %29, align 8
  %31 = getelementptr inbounds %struct._value, %struct._value* %8, i32 0, i32 1
  %32 = load double, double* %31, align 8
  %33 = fcmp une double %32, 0.000000e+00
  %34 = zext i1 %33 to i64
  %35 = select i1 %33, double 0.000000e+00, double 1.000000e+00
  %36 = getelementptr inbounds %struct._value, %struct._value* %8, i32 0, i32 1
  store double %35, double* %36, align 8
  %37 = bitcast %struct._value* %5 to i8*
  %38 = bitcast %struct._value* %8 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %37, i8* %38, i64 16, i32 8, i1 false)
  %39 = bitcast %struct._value* %5 to { i8, double }*
  %40 = load { i8, double }, { i8, double }* %39, align 8
  ret { i8, double } %40
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #5

; Function Attrs: noinline nounwind optnone uwtable
define { i8, double } @_binop_less(i8, double, i8, double) #0 {
  %5 = alloca %struct._value, align 8
  %6 = alloca %struct._value, align 8
  %7 = alloca %struct._value, align 8
  %8 = bitcast %struct._value* %6 to { i8, double }*
  %9 = getelementptr inbounds { i8, double }, { i8, double }* %8, i32 0, i32 0
  store i8 %0, i8* %9, align 8
  %10 = getelementptr inbounds { i8, double }, { i8, double }* %8, i32 0, i32 1
  store double %1, double* %10, align 8
  %11 = bitcast %struct._value* %7 to { i8, double }*
  %12 = getelementptr inbounds { i8, double }, { i8, double }* %11, i32 0, i32 0
  store i8 %2, i8* %12, align 8
  %13 = getelementptr inbounds { i8, double }, { i8, double }* %11, i32 0, i32 1
  store double %3, double* %13, align 8
  %14 = bitcast %struct._value* %6 to { i8, double }*
  %15 = getelementptr inbounds { i8, double }, { i8, double }* %14, i32 0, i32 0
  %16 = load i8, i8* %15, align 8
  %17 = getelementptr inbounds { i8, double }, { i8, double }* %14, i32 0, i32 1
  %18 = load double, double* %17, align 8
  %19 = bitcast %struct._value* %7 to { i8, double }*
  %20 = getelementptr inbounds { i8, double }, { i8, double }* %19, i32 0, i32 0
  %21 = load i8, i8* %20, align 8
  %22 = getelementptr inbounds { i8, double }, { i8, double }* %19, i32 0, i32 1
  %23 = load double, double* %22, align 8
  call void @_binop_typecheck(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.19, i32 0, i32 0), i8 %16, double %18, i8 zeroext 3, i8 %21, double %23, i8 zeroext 3)
  %24 = getelementptr inbounds %struct._value, %struct._value* %5, i32 0, i32 0
  store i8 2, i8* %24, align 8
  %25 = getelementptr inbounds %struct._value, %struct._value* %5, i32 0, i32 1
  %26 = getelementptr inbounds %struct._value, %struct._value* %6, i32 0, i32 1
  %27 = load double, double* %26, align 8
  %28 = getelementptr inbounds %struct._value, %struct._value* %7, i32 0, i32 1
  %29 = load double, double* %28, align 8
  %30 = fcmp olt double %27, %29
  %31 = zext i1 %30 to i64
  %32 = select i1 %30, double 1.000000e+00, double 0.000000e+00
  store double %32, double* %25, align 8
  %33 = bitcast %struct._value* %5 to { i8, double }*
  %34 = load { i8, double }, { i8, double }* %33, align 8
  ret { i8, double } %34
}

; Function Attrs: noinline nounwind optnone uwtable
define { i8, double } @_binop_lequal(i8, double, i8, double) #0 {
  %5 = alloca %struct._value, align 8
  %6 = alloca %struct._value, align 8
  %7 = alloca %struct._value, align 8
  %8 = bitcast %struct._value* %6 to { i8, double }*
  %9 = getelementptr inbounds { i8, double }, { i8, double }* %8, i32 0, i32 0
  store i8 %0, i8* %9, align 8
  %10 = getelementptr inbounds { i8, double }, { i8, double }* %8, i32 0, i32 1
  store double %1, double* %10, align 8
  %11 = bitcast %struct._value* %7 to { i8, double }*
  %12 = getelementptr inbounds { i8, double }, { i8, double }* %11, i32 0, i32 0
  store i8 %2, i8* %12, align 8
  %13 = getelementptr inbounds { i8, double }, { i8, double }* %11, i32 0, i32 1
  store double %3, double* %13, align 8
  %14 = bitcast %struct._value* %6 to { i8, double }*
  %15 = getelementptr inbounds { i8, double }, { i8, double }* %14, i32 0, i32 0
  %16 = load i8, i8* %15, align 8
  %17 = getelementptr inbounds { i8, double }, { i8, double }* %14, i32 0, i32 1
  %18 = load double, double* %17, align 8
  %19 = bitcast %struct._value* %7 to { i8, double }*
  %20 = getelementptr inbounds { i8, double }, { i8, double }* %19, i32 0, i32 0
  %21 = load i8, i8* %20, align 8
  %22 = getelementptr inbounds { i8, double }, { i8, double }* %19, i32 0, i32 1
  %23 = load double, double* %22, align 8
  call void @_binop_typecheck(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.20, i32 0, i32 0), i8 %16, double %18, i8 zeroext 3, i8 %21, double %23, i8 zeroext 3)
  %24 = getelementptr inbounds %struct._value, %struct._value* %5, i32 0, i32 0
  store i8 2, i8* %24, align 8
  %25 = getelementptr inbounds %struct._value, %struct._value* %5, i32 0, i32 1
  %26 = getelementptr inbounds %struct._value, %struct._value* %6, i32 0, i32 1
  %27 = load double, double* %26, align 8
  %28 = getelementptr inbounds %struct._value, %struct._value* %7, i32 0, i32 1
  %29 = load double, double* %28, align 8
  %30 = fcmp ole double %27, %29
  %31 = zext i1 %30 to i64
  %32 = select i1 %30, double 1.000000e+00, double 0.000000e+00
  store double %32, double* %25, align 8
  %33 = bitcast %struct._value* %5 to { i8, double }*
  %34 = load { i8, double }, { i8, double }* %33, align 8
  ret { i8, double } %34
}

; Function Attrs: noinline nounwind optnone uwtable
define { i8, double } @_binop_grtr(i8, double, i8, double) #0 {
  %5 = alloca %struct._value, align 8
  %6 = alloca %struct._value, align 8
  %7 = alloca %struct._value, align 8
  %8 = bitcast %struct._value* %6 to { i8, double }*
  %9 = getelementptr inbounds { i8, double }, { i8, double }* %8, i32 0, i32 0
  store i8 %0, i8* %9, align 8
  %10 = getelementptr inbounds { i8, double }, { i8, double }* %8, i32 0, i32 1
  store double %1, double* %10, align 8
  %11 = bitcast %struct._value* %7 to { i8, double }*
  %12 = getelementptr inbounds { i8, double }, { i8, double }* %11, i32 0, i32 0
  store i8 %2, i8* %12, align 8
  %13 = getelementptr inbounds { i8, double }, { i8, double }* %11, i32 0, i32 1
  store double %3, double* %13, align 8
  %14 = bitcast %struct._value* %6 to { i8, double }*
  %15 = getelementptr inbounds { i8, double }, { i8, double }* %14, i32 0, i32 0
  %16 = load i8, i8* %15, align 8
  %17 = getelementptr inbounds { i8, double }, { i8, double }* %14, i32 0, i32 1
  %18 = load double, double* %17, align 8
  %19 = bitcast %struct._value* %7 to { i8, double }*
  %20 = getelementptr inbounds { i8, double }, { i8, double }* %19, i32 0, i32 0
  %21 = load i8, i8* %20, align 8
  %22 = getelementptr inbounds { i8, double }, { i8, double }* %19, i32 0, i32 1
  %23 = load double, double* %22, align 8
  call void @_binop_typecheck(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.21, i32 0, i32 0), i8 %16, double %18, i8 zeroext 3, i8 %21, double %23, i8 zeroext 3)
  %24 = getelementptr inbounds %struct._value, %struct._value* %5, i32 0, i32 0
  store i8 2, i8* %24, align 8
  %25 = getelementptr inbounds %struct._value, %struct._value* %5, i32 0, i32 1
  %26 = getelementptr inbounds %struct._value, %struct._value* %6, i32 0, i32 1
  %27 = load double, double* %26, align 8
  %28 = getelementptr inbounds %struct._value, %struct._value* %7, i32 0, i32 1
  %29 = load double, double* %28, align 8
  %30 = fcmp ogt double %27, %29
  %31 = zext i1 %30 to i64
  %32 = select i1 %30, double 1.000000e+00, double 0.000000e+00
  store double %32, double* %25, align 8
  %33 = bitcast %struct._value* %5 to { i8, double }*
  %34 = load { i8, double }, { i8, double }* %33, align 8
  ret { i8, double } %34
}

; Function Attrs: noinline nounwind optnone uwtable
define { i8, double } @_binop_grequal(i8, double, i8, double) #0 {
  %5 = alloca %struct._value, align 8
  %6 = alloca %struct._value, align 8
  %7 = alloca %struct._value, align 8
  %8 = bitcast %struct._value* %6 to { i8, double }*
  %9 = getelementptr inbounds { i8, double }, { i8, double }* %8, i32 0, i32 0
  store i8 %0, i8* %9, align 8
  %10 = getelementptr inbounds { i8, double }, { i8, double }* %8, i32 0, i32 1
  store double %1, double* %10, align 8
  %11 = bitcast %struct._value* %7 to { i8, double }*
  %12 = getelementptr inbounds { i8, double }, { i8, double }* %11, i32 0, i32 0
  store i8 %2, i8* %12, align 8
  %13 = getelementptr inbounds { i8, double }, { i8, double }* %11, i32 0, i32 1
  store double %3, double* %13, align 8
  %14 = bitcast %struct._value* %6 to { i8, double }*
  %15 = getelementptr inbounds { i8, double }, { i8, double }* %14, i32 0, i32 0
  %16 = load i8, i8* %15, align 8
  %17 = getelementptr inbounds { i8, double }, { i8, double }* %14, i32 0, i32 1
  %18 = load double, double* %17, align 8
  %19 = bitcast %struct._value* %7 to { i8, double }*
  %20 = getelementptr inbounds { i8, double }, { i8, double }* %19, i32 0, i32 0
  %21 = load i8, i8* %20, align 8
  %22 = getelementptr inbounds { i8, double }, { i8, double }* %19, i32 0, i32 1
  %23 = load double, double* %22, align 8
  call void @_binop_typecheck(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.22, i32 0, i32 0), i8 %16, double %18, i8 zeroext 3, i8 %21, double %23, i8 zeroext 3)
  %24 = getelementptr inbounds %struct._value, %struct._value* %5, i32 0, i32 0
  store i8 2, i8* %24, align 8
  %25 = getelementptr inbounds %struct._value, %struct._value* %5, i32 0, i32 1
  %26 = getelementptr inbounds %struct._value, %struct._value* %6, i32 0, i32 1
  %27 = load double, double* %26, align 8
  %28 = getelementptr inbounds %struct._value, %struct._value* %7, i32 0, i32 1
  %29 = load double, double* %28, align 8
  %30 = fcmp oge double %27, %29
  %31 = zext i1 %30 to i64
  %32 = select i1 %30, double 1.000000e+00, double 0.000000e+00
  store double %32, double* %25, align 8
  %33 = bitcast %struct._value* %5 to { i8, double }*
  %34 = load { i8, double }, { i8, double }* %33, align 8
  ret { i8, double } %34
}

; Function Attrs: noinline nounwind optnone uwtable
define { i8, double } @_binop_and(i8, double, i8, double) #0 {
  %5 = alloca %struct._value, align 8
  %6 = alloca %struct._value, align 8
  %7 = alloca %struct._value, align 8
  %8 = bitcast %struct._value* %6 to { i8, double }*
  %9 = getelementptr inbounds { i8, double }, { i8, double }* %8, i32 0, i32 0
  store i8 %0, i8* %9, align 8
  %10 = getelementptr inbounds { i8, double }, { i8, double }* %8, i32 0, i32 1
  store double %1, double* %10, align 8
  %11 = bitcast %struct._value* %7 to { i8, double }*
  %12 = getelementptr inbounds { i8, double }, { i8, double }* %11, i32 0, i32 0
  store i8 %2, i8* %12, align 8
  %13 = getelementptr inbounds { i8, double }, { i8, double }* %11, i32 0, i32 1
  store double %3, double* %13, align 8
  %14 = bitcast %struct._value* %6 to { i8, double }*
  %15 = getelementptr inbounds { i8, double }, { i8, double }* %14, i32 0, i32 0
  %16 = load i8, i8* %15, align 8
  %17 = getelementptr inbounds { i8, double }, { i8, double }* %14, i32 0, i32 1
  %18 = load double, double* %17, align 8
  %19 = bitcast %struct._value* %7 to { i8, double }*
  %20 = getelementptr inbounds { i8, double }, { i8, double }* %19, i32 0, i32 0
  %21 = load i8, i8* %20, align 8
  %22 = getelementptr inbounds { i8, double }, { i8, double }* %19, i32 0, i32 1
  %23 = load double, double* %22, align 8
  call void @_binop_typecheck(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.23, i32 0, i32 0), i8 %16, double %18, i8 zeroext 2, i8 %21, double %23, i8 zeroext 2)
  %24 = getelementptr inbounds %struct._value, %struct._value* %5, i32 0, i32 0
  store i8 2, i8* %24, align 8
  %25 = getelementptr inbounds %struct._value, %struct._value* %5, i32 0, i32 1
  %26 = getelementptr inbounds %struct._value, %struct._value* %6, i32 0, i32 1
  %27 = load double, double* %26, align 8
  %28 = fcmp une double %27, 0.000000e+00
  br i1 %28, label %29, label %33

; <label>:29:                                     ; preds = %4
  %30 = getelementptr inbounds %struct._value, %struct._value* %7, i32 0, i32 1
  %31 = load double, double* %30, align 8
  %32 = fcmp une double %31, 0.000000e+00
  br label %33

; <label>:33:                                     ; preds = %29, %4
  %34 = phi i1 [ false, %4 ], [ %32, %29 ]
  %35 = zext i1 %34 to i64
  %36 = select i1 %34, double 1.000000e+00, double 0.000000e+00
  store double %36, double* %25, align 8
  %37 = bitcast %struct._value* %5 to { i8, double }*
  %38 = load { i8, double }, { i8, double }* %37, align 8
  ret { i8, double } %38
}

; Function Attrs: noinline nounwind optnone uwtable
define { i8, double } @_binop_or(i8, double, i8, double) #0 {
  %5 = alloca %struct._value, align 8
  %6 = alloca %struct._value, align 8
  %7 = alloca %struct._value, align 8
  %8 = bitcast %struct._value* %6 to { i8, double }*
  %9 = getelementptr inbounds { i8, double }, { i8, double }* %8, i32 0, i32 0
  store i8 %0, i8* %9, align 8
  %10 = getelementptr inbounds { i8, double }, { i8, double }* %8, i32 0, i32 1
  store double %1, double* %10, align 8
  %11 = bitcast %struct._value* %7 to { i8, double }*
  %12 = getelementptr inbounds { i8, double }, { i8, double }* %11, i32 0, i32 0
  store i8 %2, i8* %12, align 8
  %13 = getelementptr inbounds { i8, double }, { i8, double }* %11, i32 0, i32 1
  store double %3, double* %13, align 8
  %14 = bitcast %struct._value* %6 to { i8, double }*
  %15 = getelementptr inbounds { i8, double }, { i8, double }* %14, i32 0, i32 0
  %16 = load i8, i8* %15, align 8
  %17 = getelementptr inbounds { i8, double }, { i8, double }* %14, i32 0, i32 1
  %18 = load double, double* %17, align 8
  %19 = bitcast %struct._value* %7 to { i8, double }*
  %20 = getelementptr inbounds { i8, double }, { i8, double }* %19, i32 0, i32 0
  %21 = load i8, i8* %20, align 8
  %22 = getelementptr inbounds { i8, double }, { i8, double }* %19, i32 0, i32 1
  %23 = load double, double* %22, align 8
  call void @_binop_typecheck(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.24, i32 0, i32 0), i8 %16, double %18, i8 zeroext 2, i8 %21, double %23, i8 zeroext 2)
  %24 = getelementptr inbounds %struct._value, %struct._value* %5, i32 0, i32 0
  store i8 2, i8* %24, align 8
  %25 = getelementptr inbounds %struct._value, %struct._value* %5, i32 0, i32 1
  %26 = getelementptr inbounds %struct._value, %struct._value* %6, i32 0, i32 1
  %27 = load double, double* %26, align 8
  %28 = fcmp une double %27, 0.000000e+00
  br i1 %28, label %33, label %29

; <label>:29:                                     ; preds = %4
  %30 = getelementptr inbounds %struct._value, %struct._value* %7, i32 0, i32 1
  %31 = load double, double* %30, align 8
  %32 = fcmp une double %31, 0.000000e+00
  br label %33

; <label>:33:                                     ; preds = %29, %4
  %34 = phi i1 [ true, %4 ], [ %32, %29 ]
  %35 = zext i1 %34 to i64
  %36 = select i1 %34, double 1.000000e+00, double 0.000000e+00
  store double %36, double* %25, align 8
  %37 = bitcast %struct._value* %5 to { i8, double }*
  %38 = load { i8, double }, { i8, double }* %37, align 8
  ret { i8, double } %38
}

; Function Attrs: noinline nounwind optnone uwtable
define { i8, double } @_unop_not(i8, double) #0 {
  %3 = alloca %struct._value, align 8
  %4 = alloca %struct._value, align 8
  %5 = bitcast %struct._value* %4 to { i8, double }*
  %6 = getelementptr inbounds { i8, double }, { i8, double }* %5, i32 0, i32 0
  store i8 %0, i8* %6, align 8
  %7 = getelementptr inbounds { i8, double }, { i8, double }* %5, i32 0, i32 1
  store double %1, double* %7, align 8
  %8 = bitcast %struct._value* %4 to { i8, double }*
  %9 = getelementptr inbounds { i8, double }, { i8, double }* %8, i32 0, i32 0
  %10 = load i8, i8* %9, align 8
  %11 = getelementptr inbounds { i8, double }, { i8, double }* %8, i32 0, i32 1
  %12 = load double, double* %11, align 8
  call void @_unop_typecheck(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.25, i32 0, i32 0), i8 %10, double %12, i8 zeroext 2, i8* getelementptr inbounds ([1 x i8], [1 x i8]* @.str.18, i32 0, i32 0))
  %13 = getelementptr inbounds %struct._value, %struct._value* %3, i32 0, i32 0
  store i8 2, i8* %13, align 8
  %14 = getelementptr inbounds %struct._value, %struct._value* %3, i32 0, i32 1
  %15 = getelementptr inbounds %struct._value, %struct._value* %4, i32 0, i32 1
  %16 = load double, double* %15, align 8
  %17 = fcmp une double %16, 0.000000e+00
  %18 = zext i1 %17 to i64
  %19 = select i1 %17, double 0.000000e+00, double 1.000000e+00
  store double %19, double* %14, align 8
  %20 = bitcast %struct._value* %3 to { i8, double }*
  %21 = load { i8, double }, { i8, double }* %20, align 8
  ret { i8, double } %21
}

; Function Attrs: noinline nounwind optnone uwtable
define { i8, double } @_binop_is(i8, double, i8, double) #0 {
  %5 = alloca %struct._value, align 8
  %6 = alloca %struct._value, align 8
  %7 = alloca %struct._value, align 8
  %8 = bitcast %struct._value* %6 to { i8, double }*
  %9 = getelementptr inbounds { i8, double }, { i8, double }* %8, i32 0, i32 0
  store i8 %0, i8* %9, align 8
  %10 = getelementptr inbounds { i8, double }, { i8, double }* %8, i32 0, i32 1
  store double %1, double* %10, align 8
  %11 = bitcast %struct._value* %7 to { i8, double }*
  %12 = getelementptr inbounds { i8, double }, { i8, double }* %11, i32 0, i32 0
  store i8 %2, i8* %12, align 8
  %13 = getelementptr inbounds { i8, double }, { i8, double }* %11, i32 0, i32 1
  store double %3, double* %13, align 8
  %14 = getelementptr inbounds %struct._value, %struct._value* %5, i32 0, i32 0
  store i8 2, i8* %14, align 8
  %15 = getelementptr inbounds %struct._value, %struct._value* %5, i32 0, i32 1
  %16 = getelementptr inbounds %struct._value, %struct._value* %6, i32 0, i32 0
  %17 = load i8, i8* %16, align 8
  %18 = zext i8 %17 to i32
  %19 = getelementptr inbounds %struct._value, %struct._value* %7, i32 0, i32 0
  %20 = load i8, i8* %19, align 8
  %21 = zext i8 %20 to i32
  %22 = icmp eq i32 %18, %21
  %23 = zext i1 %22 to i64
  %24 = select i1 %22, double 1.000000e+00, double 0.000000e+00
  store double %24, double* %15, align 8
  %25 = bitcast %struct._value* %5 to { i8, double }*
  %26 = load { i8, double }, { i8, double }* %25, align 8
  ret { i8, double } %26
}

; Function Attrs: noinline nounwind optnone uwtable
define zeroext i8 @_func_is_true(i8, double) #0 {
  %3 = alloca %struct._value, align 8
  %4 = bitcast %struct._value* %3 to { i8, double }*
  %5 = getelementptr inbounds { i8, double }, { i8, double }* %4, i32 0, i32 0
  store i8 %0, i8* %5, align 8
  %6 = getelementptr inbounds { i8, double }, { i8, double }* %4, i32 0, i32 1
  store double %1, double* %6, align 8
  %7 = getelementptr inbounds %struct._value, %struct._value* %3, i32 0, i32 0
  %8 = load i8, i8* %7, align 8
  %9 = zext i8 %8 to i32
  %10 = icmp ne i32 %9, 2
  br i1 %10, label %11, label %15

; <label>:11:                                     ; preds = %2
  %12 = getelementptr inbounds %struct._value, %struct._value* %3, i32 0, i32 0
  %13 = load i8, i8* %12, align 8
  %14 = call i8* @_type_str(i8 zeroext %13)
  call void (i32, i8*, ...) @_fatal(i32 101, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @.str.26, i32 0, i32 0), i8* %14)
  br label %15

; <label>:15:                                     ; preds = %11, %2
  %16 = getelementptr inbounds %struct._value, %struct._value* %3, i32 0, i32 1
  %17 = load double, double* %16, align 8
  %18 = fcmp une double %17, 0.000000e+00
  %19 = zext i1 %18 to i64
  %20 = select i1 %18, i32 1, i32 0
  %21 = trunc i32 %20 to i8
  ret i8 %21
}

; Function Attrs: noinline nounwind optnone uwtable
define { i8, double } @_func_new_composite(i8 zeroext) #0 {
  %2 = alloca %struct._value, align 8
  %3 = alloca i8, align 1
  %4 = alloca %struct._composite*, align 8
  %5 = alloca %struct._value, align 8
  store i8 %0, i8* %3, align 1
  %6 = load i8, i8* %3, align 1
  %7 = zext i8 %6 to i32
  %8 = icmp ne i32 %7, 5
  br i1 %8, label %9, label %16

; <label>:9:                                      ; preds = %1
  %10 = load i8, i8* %3, align 1
  %11 = zext i8 %10 to i32
  %12 = icmp ne i32 %11, 6
  br i1 %12, label %13, label %16

; <label>:13:                                     ; preds = %9
  %14 = load i8, i8* %3, align 1
  %15 = call i8* @_type_str(i8 zeroext %14)
  call void (i32, i8*, ...) @_fatal(i32 101, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @.str.27, i32 0, i32 0), i8* %15)
  br label %16

; <label>:16:                                     ; preds = %13, %9, %1
  %17 = call noalias i8* @malloc(i64 16) #2
  %18 = bitcast i8* %17 to %struct._composite*
  store %struct._composite* %18, %struct._composite** %4, align 8
  %19 = load %struct._composite*, %struct._composite** %4, align 8
  %20 = bitcast %struct._composite* %19 to i8*
  call void @_check_alloc(i8* %20)
  %21 = load %struct._composite*, %struct._composite** %4, align 8
  %22 = bitcast %struct._composite* %21 to i8*
  call void @llvm.memset.p0i8.i64(i8* %22, i8 0, i64 16, i32 8, i1 false)
  %23 = bitcast %struct._value* %5 to i8*
  call void @llvm.memset.p0i8.i64(i8* %23, i8 0, i64 16, i32 8, i1 false)
  %24 = load i8, i8* %3, align 1
  %25 = getelementptr inbounds %struct._value, %struct._value* %5, i32 0, i32 0
  store i8 %24, i8* %25, align 8
  %26 = getelementptr inbounds %struct._value, %struct._value* %5, i32 0, i32 1
  %27 = bitcast double* %26 to i8*
  %28 = bitcast %struct._composite** %4 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %27, i8* %28, i64 8, i32 8, i1 false)
  %29 = bitcast %struct._value* %2 to i8*
  %30 = bitcast %struct._value* %5 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %29, i8* %30, i64 16, i32 8, i1 false)
  %31 = bitcast %struct._value* %2 to { i8, double }*
  %32 = load { i8, double }, { i8, double }* %31, align 8
  ret { i8, double } %32
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #3

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i32, i1) #5

; Function Attrs: noinline nounwind optnone uwtable
define { i8, double } @_func_new_string(i8*) #0 {
  %2 = alloca %struct._value, align 8
  %3 = alloca i8*, align 8
  %4 = alloca %struct._value, align 8
  store i8* %0, i8** %3, align 8
  %5 = bitcast %struct._value* %4 to i8*
  call void @llvm.memset.p0i8.i64(i8* %5, i8 0, i64 16, i32 8, i1 false)
  %6 = getelementptr inbounds %struct._value, %struct._value* %4, i32 0, i32 0
  store i8 4, i8* %6, align 8
  %7 = getelementptr inbounds %struct._value, %struct._value* %4, i32 0, i32 1
  %8 = bitcast double* %7 to i8*
  %9 = bitcast i8** %3 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %8, i8* %9, i64 8, i32 8, i1 false)
  %10 = bitcast %struct._value* %2 to i8*
  %11 = bitcast %struct._value* %4 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %10, i8* %11, i64 16, i32 8, i1 false)
  %12 = bitcast %struct._value* %2 to { i8, double }*
  %13 = load { i8, double }, { i8, double }* %12, align 8
  ret { i8, double } %13
}

; Function Attrs: noinline nounwind optnone uwtable
define %struct._element* @_func_find_id(%struct._composite*, i32) #0 {
  %3 = alloca %struct._element*, align 8
  %4 = alloca %struct._composite*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca %struct._element*, align 8
  store %struct._composite* %0, %struct._composite** %4, align 8
  store i32 %1, i32* %5, align 4
  store i32 0, i32* %6, align 4
  br label %8

; <label>:8:                                      ; preds = %29, %2
  %9 = load i32, i32* %6, align 4
  %10 = load %struct._composite*, %struct._composite** %4, align 8
  %11 = getelementptr inbounds %struct._composite, %struct._composite* %10, i32 0, i32 0
  %12 = load i32, i32* %11, align 8
  %13 = icmp slt i32 %9, %12
  br i1 %13, label %14, label %32

; <label>:14:                                     ; preds = %8
  %15 = load %struct._composite*, %struct._composite** %4, align 8
  %16 = getelementptr inbounds %struct._composite, %struct._composite* %15, i32 0, i32 1
  %17 = load %struct._element*, %struct._element** %16, align 8
  %18 = load i32, i32* %6, align 4
  %19 = sext i32 %18 to i64
  %20 = getelementptr inbounds %struct._element, %struct._element* %17, i64 %19
  store %struct._element* %20, %struct._element** %7, align 8
  %21 = load %struct._element*, %struct._element** %7, align 8
  %22 = getelementptr inbounds %struct._element, %struct._element* %21, i32 0, i32 0
  %23 = load i32, i32* %22, align 8
  %24 = load i32, i32* %5, align 4
  %25 = icmp eq i32 %23, %24
  br i1 %25, label %26, label %28

; <label>:26:                                     ; preds = %14
  %27 = load %struct._element*, %struct._element** %7, align 8
  store %struct._element* %27, %struct._element** %3, align 8
  br label %33

; <label>:28:                                     ; preds = %14
  br label %29

; <label>:29:                                     ; preds = %28
  %30 = load i32, i32* %6, align 4
  %31 = add nsw i32 %30, 1
  store i32 %31, i32* %6, align 4
  br label %8

; <label>:32:                                     ; preds = %8
  store %struct._element* null, %struct._element** %3, align 8
  br label %33

; <label>:33:                                     ; preds = %32, %26
  %34 = load %struct._element*, %struct._element** %3, align 8
  ret %struct._element* %34
}

; Function Attrs: noinline nounwind optnone uwtable
define { i8, double } @_func_get_element(i8, double, i32) #0 {
  %4 = alloca %struct._value, align 8
  %5 = alloca %struct._value, align 8
  %6 = alloca i32, align 4
  %7 = alloca %struct._composite*, align 8
  %8 = alloca %struct._element*, align 8
  %9 = alloca %struct._value, align 8
  %10 = bitcast %struct._value* %5 to { i8, double }*
  %11 = getelementptr inbounds { i8, double }, { i8, double }* %10, i32 0, i32 0
  store i8 %0, i8* %11, align 8
  %12 = getelementptr inbounds { i8, double }, { i8, double }* %10, i32 0, i32 1
  store double %1, double* %12, align 8
  store i32 %2, i32* %6, align 4
  %13 = getelementptr inbounds %struct._value, %struct._value* %5, i32 0, i32 0
  %14 = load i8, i8* %13, align 8
  %15 = zext i8 %14 to i32
  %16 = icmp eq i32 %15, 5
  br i1 %16, label %22, label %17

; <label>:17:                                     ; preds = %3
  %18 = getelementptr inbounds %struct._value, %struct._value* %5, i32 0, i32 0
  %19 = load i8, i8* %18, align 8
  %20 = zext i8 %19 to i32
  %21 = icmp eq i32 %20, 6
  br i1 %21, label %22, label %37

; <label>:22:                                     ; preds = %17, %3
  %23 = getelementptr inbounds %struct._value, %struct._value* %5, i32 0, i32 1
  %24 = bitcast double* %23 to %struct._composite**
  %25 = load %struct._composite*, %struct._composite** %24, align 8
  store %struct._composite* %25, %struct._composite** %7, align 8
  %26 = load %struct._composite*, %struct._composite** %7, align 8
  %27 = load i32, i32* %6, align 4
  %28 = call %struct._element* @_func_find_id(%struct._composite* %26, i32 %27)
  store %struct._element* %28, %struct._element** %8, align 8
  %29 = load %struct._element*, %struct._element** %8, align 8
  %30 = icmp ne %struct._element* %29, null
  br i1 %30, label %31, label %36

; <label>:31:                                     ; preds = %22
  %32 = load %struct._element*, %struct._element** %8, align 8
  %33 = getelementptr inbounds %struct._element, %struct._element* %32, i32 0, i32 1
  %34 = bitcast %struct._value* %4 to i8*
  %35 = bitcast %struct._value* %33 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %34, i8* %35, i64 16, i32 8, i1 false)
  br label %42

; <label>:36:                                     ; preds = %22
  br label %37

; <label>:37:                                     ; preds = %36, %17
  %38 = bitcast %struct._value* %9 to i8*
  call void @llvm.memset.p0i8.i64(i8* %38, i8 0, i64 16, i32 8, i1 false)
  %39 = getelementptr inbounds %struct._value, %struct._value* %9, i32 0, i32 0
  store i8 1, i8* %39, align 8
  %40 = bitcast %struct._value* %4 to i8*
  %41 = bitcast %struct._value* %9 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %40, i8* %41, i64 16, i32 8, i1 false)
  br label %42

; <label>:42:                                     ; preds = %37, %31
  %43 = bitcast %struct._value* %4 to { i8, double }*
  %44 = load { i8, double }, { i8, double }* %43, align 8
  ret { i8, double } %44
}

; Function Attrs: noinline nounwind optnone uwtable
define { i8, double } @_func_set_element(i8, double, i32, i8, double) #0 {
  %6 = alloca %struct._value, align 8
  %7 = alloca %struct._value, align 8
  %8 = alloca %struct._value, align 8
  %9 = alloca i32, align 4
  %10 = alloca %struct._composite*, align 8
  %11 = alloca %struct._element*, align 8
  %12 = bitcast %struct._value* %7 to { i8, double }*
  %13 = getelementptr inbounds { i8, double }, { i8, double }* %12, i32 0, i32 0
  store i8 %0, i8* %13, align 8
  %14 = getelementptr inbounds { i8, double }, { i8, double }* %12, i32 0, i32 1
  store double %1, double* %14, align 8
  %15 = bitcast %struct._value* %8 to { i8, double }*
  %16 = getelementptr inbounds { i8, double }, { i8, double }* %15, i32 0, i32 0
  store i8 %3, i8* %16, align 8
  %17 = getelementptr inbounds { i8, double }, { i8, double }* %15, i32 0, i32 1
  store double %4, double* %17, align 8
  store i32 %2, i32* %9, align 4
  %18 = getelementptr inbounds %struct._value, %struct._value* %7, i32 0, i32 0
  %19 = load i8, i8* %18, align 8
  %20 = zext i8 %19 to i32
  %21 = icmp ne i32 %20, 5
  br i1 %21, label %22, label %31

; <label>:22:                                     ; preds = %5
  %23 = getelementptr inbounds %struct._value, %struct._value* %7, i32 0, i32 0
  %24 = load i8, i8* %23, align 8
  %25 = zext i8 %24 to i32
  %26 = icmp ne i32 %25, 6
  br i1 %26, label %27, label %31

; <label>:27:                                     ; preds = %22
  %28 = getelementptr inbounds %struct._value, %struct._value* %7, i32 0, i32 0
  %29 = load i8, i8* %28, align 8
  %30 = call i8* @_type_str(i8 zeroext %29)
  call void (i32, i8*, ...) @_fatal(i32 101, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @.str.27, i32 0, i32 0), i8* %30)
  br label %31

; <label>:31:                                     ; preds = %27, %22, %5
  %32 = getelementptr inbounds %struct._value, %struct._value* %7, i32 0, i32 1
  %33 = bitcast double* %32 to %struct._composite**
  %34 = load %struct._composite*, %struct._composite** %33, align 8
  store %struct._composite* %34, %struct._composite** %10, align 8
  %35 = load %struct._composite*, %struct._composite** %10, align 8
  %36 = load i32, i32* %9, align 4
  %37 = call %struct._element* @_func_find_id(%struct._composite* %35, i32 %36)
  store %struct._element* %37, %struct._element** %11, align 8
  %38 = load %struct._element*, %struct._element** %11, align 8
  %39 = icmp ne %struct._element* %38, null
  br i1 %39, label %40, label %47

; <label>:40:                                     ; preds = %31
  %41 = load %struct._element*, %struct._element** %11, align 8
  %42 = getelementptr inbounds %struct._element, %struct._element* %41, i32 0, i32 1
  %43 = bitcast %struct._value* %42 to i8*
  %44 = bitcast %struct._value* %8 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %43, i8* %44, i64 16, i32 8, i1 false)
  %45 = bitcast %struct._value* %6 to i8*
  %46 = bitcast %struct._value* %8 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %45, i8* %46, i64 16, i32 8, i1 false)
  br label %94

; <label>:47:                                     ; preds = %31
  %48 = load %struct._composite*, %struct._composite** %10, align 8
  %49 = getelementptr inbounds %struct._composite, %struct._composite* %48, i32 0, i32 0
  %50 = load i32, i32* %49, align 8
  %51 = srem i32 %50, 16
  %52 = icmp ne i32 %51, 0
  br i1 %52, label %72, label %53

; <label>:53:                                     ; preds = %47
  %54 = load %struct._composite*, %struct._composite** %10, align 8
  %55 = getelementptr inbounds %struct._composite, %struct._composite* %54, i32 0, i32 1
  %56 = load %struct._element*, %struct._element** %55, align 8
  %57 = bitcast %struct._element* %56 to i8*
  %58 = load %struct._composite*, %struct._composite** %10, align 8
  %59 = getelementptr inbounds %struct._composite, %struct._composite* %58, i32 0, i32 0
  %60 = load i32, i32* %59, align 8
  %61 = add nsw i32 %60, 16
  %62 = sext i32 %61 to i64
  %63 = mul i64 24, %62
  %64 = call i8* @realloc(i8* %57, i64 %63) #2
  %65 = bitcast i8* %64 to %struct._element*
  %66 = load %struct._composite*, %struct._composite** %10, align 8
  %67 = getelementptr inbounds %struct._composite, %struct._composite* %66, i32 0, i32 1
  store %struct._element* %65, %struct._element** %67, align 8
  %68 = load %struct._composite*, %struct._composite** %10, align 8
  %69 = getelementptr inbounds %struct._composite, %struct._composite* %68, i32 0, i32 1
  %70 = load %struct._element*, %struct._element** %69, align 8
  %71 = bitcast %struct._element* %70 to i8*
  call void @_check_alloc(i8* %71)
  br label %72

; <label>:72:                                     ; preds = %53, %47
  %73 = load %struct._composite*, %struct._composite** %10, align 8
  %74 = getelementptr inbounds %struct._composite, %struct._composite* %73, i32 0, i32 1
  %75 = load %struct._element*, %struct._element** %74, align 8
  %76 = load %struct._composite*, %struct._composite** %10, align 8
  %77 = getelementptr inbounds %struct._composite, %struct._composite* %76, i32 0, i32 0
  %78 = load i32, i32* %77, align 8
  %79 = sext i32 %78 to i64
  %80 = getelementptr inbounds %struct._element, %struct._element* %75, i64 %79
  store %struct._element* %80, %struct._element** %11, align 8
  %81 = load i32, i32* %9, align 4
  %82 = load %struct._element*, %struct._element** %11, align 8
  %83 = getelementptr inbounds %struct._element, %struct._element* %82, i32 0, i32 0
  store i32 %81, i32* %83, align 8
  %84 = load %struct._element*, %struct._element** %11, align 8
  %85 = getelementptr inbounds %struct._element, %struct._element* %84, i32 0, i32 1
  %86 = bitcast %struct._value* %85 to i8*
  %87 = bitcast %struct._value* %8 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %86, i8* %87, i64 16, i32 8, i1 false)
  %88 = load %struct._composite*, %struct._composite** %10, align 8
  %89 = getelementptr inbounds %struct._composite, %struct._composite* %88, i32 0, i32 0
  %90 = load i32, i32* %89, align 8
  %91 = add nsw i32 %90, 1
  store i32 %91, i32* %89, align 8
  %92 = bitcast %struct._value* %6 to i8*
  %93 = bitcast %struct._value* %8 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %92, i8* %93, i64 16, i32 8, i1 false)
  br label %94

; <label>:94:                                     ; preds = %72, %40
  %95 = bitcast %struct._value* %6 to { i8, double }*
  %96 = load { i8, double }, { i8, double }* %95, align 8
  ret { i8, double } %96
}

; Function Attrs: nounwind
declare i8* @realloc(i8*, i64) #3

; Function Attrs: noinline nounwind optnone uwtable
define { i8, double } @_binop_get_char(i8, double, i32) #0 {
  %4 = alloca %struct._value, align 8
  %5 = alloca %struct._value, align 8
  %6 = alloca i32, align 4
  %7 = alloca i8*, align 8
  %8 = alloca i64, align 8
  %9 = alloca %struct._value, align 8
  %10 = alloca i8*, align 8
  %11 = bitcast %struct._value* %5 to { i8, double }*
  %12 = getelementptr inbounds { i8, double }, { i8, double }* %11, i32 0, i32 0
  store i8 %0, i8* %12, align 8
  %13 = getelementptr inbounds { i8, double }, { i8, double }* %11, i32 0, i32 1
  store double %1, double* %13, align 8
  store i32 %2, i32* %6, align 4
  %14 = getelementptr inbounds %struct._value, %struct._value* %5, i32 0, i32 0
  %15 = load i8, i8* %14, align 8
  %16 = zext i8 %15 to i32
  %17 = icmp ne i32 %16, 4
  br i1 %17, label %18, label %22

; <label>:18:                                     ; preds = %3
  %19 = getelementptr inbounds %struct._value, %struct._value* %5, i32 0, i32 0
  %20 = load i8, i8* %19, align 8
  %21 = call i8* @_type_str(i8 zeroext %20)
  call void (i32, i8*, ...) @_fatal(i32 101, i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.28, i32 0, i32 0), i8* %21)
  br label %22

; <label>:22:                                     ; preds = %18, %3
  %23 = getelementptr inbounds %struct._value, %struct._value* %5, i32 0, i32 1
  %24 = bitcast double* %23 to i8**
  %25 = load i8*, i8** %24, align 8
  store i8* %25, i8** %7, align 8
  %26 = load i8*, i8** %7, align 8
  %27 = call i64 @strlen(i8* %26) #9
  store i64 %27, i64* %8, align 8
  %28 = bitcast %struct._value* %9 to i8*
  call void @llvm.memset.p0i8.i64(i8* %28, i8 0, i64 16, i32 8, i1 false)
  %29 = load i32, i32* %6, align 4
  %30 = icmp slt i32 %29, 0
  br i1 %30, label %36, label %31

; <label>:31:                                     ; preds = %22
  %32 = load i32, i32* %6, align 4
  %33 = sext i32 %32 to i64
  %34 = load i64, i64* %8, align 8
  %35 = icmp uge i64 %33, %34
  br i1 %35, label %36, label %40

; <label>:36:                                     ; preds = %31, %22
  %37 = getelementptr inbounds %struct._value, %struct._value* %9, i32 0, i32 0
  store i8 1, i8* %37, align 8
  %38 = bitcast %struct._value* %4 to i8*
  %39 = bitcast %struct._value* %9 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %38, i8* %39, i64 16, i32 8, i1 false)
  br label %57

; <label>:40:                                     ; preds = %31
  %41 = call noalias i8* @calloc(i64 2, i64 1) #2
  store i8* %41, i8** %10, align 8
  %42 = load i8*, i8** %10, align 8
  call void @_check_alloc(i8* %42)
  %43 = load i8*, i8** %10, align 8
  call void @llvm.memset.p0i8.i64(i8* %43, i8 0, i64 2, i32 1, i1 false)
  %44 = load i8*, i8** %7, align 8
  %45 = load i32, i32* %6, align 4
  %46 = sext i32 %45 to i64
  %47 = getelementptr inbounds i8, i8* %44, i64 %46
  %48 = load i8, i8* %47, align 1
  %49 = load i8*, i8** %10, align 8
  %50 = getelementptr inbounds i8, i8* %49, i64 0
  store i8 %48, i8* %50, align 1
  %51 = getelementptr inbounds %struct._value, %struct._value* %9, i32 0, i32 0
  store i8 4, i8* %51, align 8
  %52 = getelementptr inbounds %struct._value, %struct._value* %9, i32 0, i32 1
  %53 = bitcast double* %52 to i8*
  %54 = bitcast i8** %10 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %53, i8* %54, i64 8, i32 8, i1 false)
  %55 = bitcast %struct._value* %4 to i8*
  %56 = bitcast %struct._value* %9 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %55, i8* %56, i64 16, i32 8, i1 false)
  br label %57

; <label>:57:                                     ; preds = %40, %36
  %58 = bitcast %struct._value* %4 to { i8, double }*
  %59 = load { i8, double }, { i8, double }* %58, align 8
  ret { i8, double } %59
}

; Function Attrs: nounwind readonly
declare i64 @strlen(i8*) #6

; Function Attrs: nounwind
declare noalias i8* @calloc(i64, i64) #3

; Function Attrs: noinline nounwind optnone uwtable
define { i8, double } @_binop_get_value(i8, double, i8, double) #0 {
  %5 = alloca %struct._value, align 8
  %6 = alloca %struct._value, align 8
  %7 = alloca %struct._value, align 8
  %8 = bitcast %struct._value* %6 to { i8, double }*
  %9 = getelementptr inbounds { i8, double }, { i8, double }* %8, i32 0, i32 0
  store i8 %0, i8* %9, align 8
  %10 = getelementptr inbounds { i8, double }, { i8, double }* %8, i32 0, i32 1
  store double %1, double* %10, align 8
  %11 = bitcast %struct._value* %7 to { i8, double }*
  %12 = getelementptr inbounds { i8, double }, { i8, double }* %11, i32 0, i32 0
  store i8 %2, i8* %12, align 8
  %13 = getelementptr inbounds { i8, double }, { i8, double }* %11, i32 0, i32 1
  store double %3, double* %13, align 8
  %14 = getelementptr inbounds %struct._value, %struct._value* %6, i32 0, i32 0
  %15 = load i8, i8* %14, align 8
  %16 = zext i8 %15 to i32
  %17 = icmp eq i32 %16, 4
  br i1 %17, label %18, label %43

; <label>:18:                                     ; preds = %4
  %19 = bitcast %struct._value* %6 to { i8, double }*
  %20 = getelementptr inbounds { i8, double }, { i8, double }* %19, i32 0, i32 0
  %21 = load i8, i8* %20, align 8
  %22 = getelementptr inbounds { i8, double }, { i8, double }* %19, i32 0, i32 1
  %23 = load double, double* %22, align 8
  %24 = bitcast %struct._value* %7 to { i8, double }*
  %25 = getelementptr inbounds { i8, double }, { i8, double }* %24, i32 0, i32 0
  %26 = load i8, i8* %25, align 8
  %27 = getelementptr inbounds { i8, double }, { i8, double }* %24, i32 0, i32 1
  %28 = load double, double* %27, align 8
  call void @_binop_typecheck(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.29, i32 0, i32 0), i8 %21, double %23, i8 zeroext 4, i8 %26, double %28, i8 zeroext 3)
  %29 = getelementptr inbounds %struct._value, %struct._value* %7, i32 0, i32 1
  %30 = load double, double* %29, align 8
  %31 = fptosi double %30 to i32
  %32 = bitcast %struct._value* %6 to { i8, double }*
  %33 = getelementptr inbounds { i8, double }, { i8, double }* %32, i32 0, i32 0
  %34 = load i8, i8* %33, align 8
  %35 = getelementptr inbounds { i8, double }, { i8, double }* %32, i32 0, i32 1
  %36 = load double, double* %35, align 8
  %37 = call { i8, double } @_binop_get_char(i8 %34, double %36, i32 %31)
  %38 = bitcast %struct._value* %5 to { i8, double }*
  %39 = getelementptr inbounds { i8, double }, { i8, double }* %38, i32 0, i32 0
  %40 = extractvalue { i8, double } %37, 0
  store i8 %40, i8* %39, align 8
  %41 = getelementptr inbounds { i8, double }, { i8, double }* %38, i32 0, i32 1
  %42 = extractvalue { i8, double } %37, 1
  store double %42, double* %41, align 8
  br label %85

; <label>:43:                                     ; preds = %4
  %44 = getelementptr inbounds %struct._value, %struct._value* %6, i32 0, i32 0
  %45 = load i8, i8* %44, align 8
  %46 = zext i8 %45 to i32
  %47 = icmp eq i32 %46, 5
  br i1 %47, label %48, label %59

; <label>:48:                                     ; preds = %43
  %49 = bitcast %struct._value* %6 to { i8, double }*
  %50 = getelementptr inbounds { i8, double }, { i8, double }* %49, i32 0, i32 0
  %51 = load i8, i8* %50, align 8
  %52 = getelementptr inbounds { i8, double }, { i8, double }* %49, i32 0, i32 1
  %53 = load double, double* %52, align 8
  %54 = bitcast %struct._value* %7 to { i8, double }*
  %55 = getelementptr inbounds { i8, double }, { i8, double }* %54, i32 0, i32 0
  %56 = load i8, i8* %55, align 8
  %57 = getelementptr inbounds { i8, double }, { i8, double }* %54, i32 0, i32 1
  %58 = load double, double* %57, align 8
  call void @_binop_typecheck(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.30, i32 0, i32 0), i8 %51, double %53, i8 zeroext 5, i8 %56, double %58, i8 zeroext 3)
  br label %70

; <label>:59:                                     ; preds = %43
  %60 = bitcast %struct._value* %6 to { i8, double }*
  %61 = getelementptr inbounds { i8, double }, { i8, double }* %60, i32 0, i32 0
  %62 = load i8, i8* %61, align 8
  %63 = getelementptr inbounds { i8, double }, { i8, double }* %60, i32 0, i32 1
  %64 = load double, double* %63, align 8
  %65 = bitcast %struct._value* %7 to { i8, double }*
  %66 = getelementptr inbounds { i8, double }, { i8, double }* %65, i32 0, i32 0
  %67 = load i8, i8* %66, align 8
  %68 = getelementptr inbounds { i8, double }, { i8, double }* %65, i32 0, i32 1
  %69 = load double, double* %68, align 8
  call void @_binop_typecheck(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.29, i32 0, i32 0), i8 %62, double %64, i8 zeroext 6, i8 %67, double %69, i8 zeroext 3)
  br label %70

; <label>:70:                                     ; preds = %59, %48
  %71 = getelementptr inbounds %struct._value, %struct._value* %7, i32 0, i32 1
  %72 = load double, double* %71, align 8
  %73 = fptosi double %72 to i32
  %74 = bitcast %struct._value* %6 to { i8, double }*
  %75 = getelementptr inbounds { i8, double }, { i8, double }* %74, i32 0, i32 0
  %76 = load i8, i8* %75, align 8
  %77 = getelementptr inbounds { i8, double }, { i8, double }* %74, i32 0, i32 1
  %78 = load double, double* %77, align 8
  %79 = call { i8, double } @_func_get_element(i8 %76, double %78, i32 %73)
  %80 = bitcast %struct._value* %5 to { i8, double }*
  %81 = getelementptr inbounds { i8, double }, { i8, double }* %80, i32 0, i32 0
  %82 = extractvalue { i8, double } %79, 0
  store i8 %82, i8* %81, align 8
  %83 = getelementptr inbounds { i8, double }, { i8, double }* %80, i32 0, i32 1
  %84 = extractvalue { i8, double } %79, 1
  store double %84, double* %83, align 8
  br label %85

; <label>:85:                                     ; preds = %70, %18
  %86 = bitcast %struct._value* %5 to { i8, double }*
  %87 = load { i8, double }, { i8, double }* %86, align 8
  ret { i8, double } %87
}

; Function Attrs: noinline nounwind optnone uwtable
define { i8, double } @_func_set_value(i8, double, i8, double, i8, double) #0 {
  %7 = alloca %struct._value, align 8
  %8 = alloca %struct._value, align 8
  %9 = alloca %struct._value, align 8
  %10 = alloca %struct._value, align 8
  %11 = bitcast %struct._value* %8 to { i8, double }*
  %12 = getelementptr inbounds { i8, double }, { i8, double }* %11, i32 0, i32 0
  store i8 %0, i8* %12, align 8
  %13 = getelementptr inbounds { i8, double }, { i8, double }* %11, i32 0, i32 1
  store double %1, double* %13, align 8
  %14 = bitcast %struct._value* %9 to { i8, double }*
  %15 = getelementptr inbounds { i8, double }, { i8, double }* %14, i32 0, i32 0
  store i8 %2, i8* %15, align 8
  %16 = getelementptr inbounds { i8, double }, { i8, double }* %14, i32 0, i32 1
  store double %3, double* %16, align 8
  %17 = bitcast %struct._value* %10 to { i8, double }*
  %18 = getelementptr inbounds { i8, double }, { i8, double }* %17, i32 0, i32 0
  store i8 %4, i8* %18, align 8
  %19 = getelementptr inbounds { i8, double }, { i8, double }* %17, i32 0, i32 1
  store double %5, double* %19, align 8
  %20 = getelementptr inbounds %struct._value, %struct._value* %8, i32 0, i32 0
  %21 = load i8, i8* %20, align 8
  %22 = zext i8 %21 to i32
  %23 = icmp eq i32 %22, 5
  br i1 %23, label %24, label %35

; <label>:24:                                     ; preds = %6
  %25 = bitcast %struct._value* %8 to { i8, double }*
  %26 = getelementptr inbounds { i8, double }, { i8, double }* %25, i32 0, i32 0
  %27 = load i8, i8* %26, align 8
  %28 = getelementptr inbounds { i8, double }, { i8, double }* %25, i32 0, i32 1
  %29 = load double, double* %28, align 8
  %30 = bitcast %struct._value* %9 to { i8, double }*
  %31 = getelementptr inbounds { i8, double }, { i8, double }* %30, i32 0, i32 0
  %32 = load i8, i8* %31, align 8
  %33 = getelementptr inbounds { i8, double }, { i8, double }* %30, i32 0, i32 1
  %34 = load double, double* %33, align 8
  call void @_binop_typecheck(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.30, i32 0, i32 0), i8 %27, double %29, i8 zeroext 5, i8 %32, double %34, i8 zeroext 3)
  br label %46

; <label>:35:                                     ; preds = %6
  %36 = bitcast %struct._value* %8 to { i8, double }*
  %37 = getelementptr inbounds { i8, double }, { i8, double }* %36, i32 0, i32 0
  %38 = load i8, i8* %37, align 8
  %39 = getelementptr inbounds { i8, double }, { i8, double }* %36, i32 0, i32 1
  %40 = load double, double* %39, align 8
  %41 = bitcast %struct._value* %9 to { i8, double }*
  %42 = getelementptr inbounds { i8, double }, { i8, double }* %41, i32 0, i32 0
  %43 = load i8, i8* %42, align 8
  %44 = getelementptr inbounds { i8, double }, { i8, double }* %41, i32 0, i32 1
  %45 = load double, double* %44, align 8
  call void @_binop_typecheck(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.29, i32 0, i32 0), i8 %38, double %40, i8 zeroext 6, i8 %43, double %45, i8 zeroext 3)
  br label %46

; <label>:46:                                     ; preds = %35, %24
  %47 = getelementptr inbounds %struct._value, %struct._value* %9, i32 0, i32 1
  %48 = load double, double* %47, align 8
  %49 = fptosi double %48 to i32
  %50 = bitcast %struct._value* %8 to { i8, double }*
  %51 = getelementptr inbounds { i8, double }, { i8, double }* %50, i32 0, i32 0
  %52 = load i8, i8* %51, align 8
  %53 = getelementptr inbounds { i8, double }, { i8, double }* %50, i32 0, i32 1
  %54 = load double, double* %53, align 8
  %55 = bitcast %struct._value* %10 to { i8, double }*
  %56 = getelementptr inbounds { i8, double }, { i8, double }* %55, i32 0, i32 0
  %57 = load i8, i8* %56, align 8
  %58 = getelementptr inbounds { i8, double }, { i8, double }* %55, i32 0, i32 1
  %59 = load double, double* %58, align 8
  %60 = call { i8, double } @_func_set_element(i8 %52, double %54, i32 %49, i8 %57, double %59)
  %61 = bitcast %struct._value* %7 to { i8, double }*
  %62 = getelementptr inbounds { i8, double }, { i8, double }* %61, i32 0, i32 0
  %63 = extractvalue { i8, double } %60, 0
  store i8 %63, i8* %62, align 8
  %64 = getelementptr inbounds { i8, double }, { i8, double }* %61, i32 0, i32 1
  %65 = extractvalue { i8, double } %60, 1
  store double %65, double* %64, align 8
  %66 = bitcast %struct._value* %7 to { i8, double }*
  %67 = load { i8, double }, { i8, double }* %66, align 8
  ret { i8, double } %67
}

; Function Attrs: noinline nounwind optnone uwtable
define { i8, double } @_unop_len(i8, double) #0 {
  %3 = alloca %struct._value, align 8
  %4 = alloca %struct._value, align 8
  %5 = alloca i8*, align 8
  %6 = alloca i64, align 8
  %7 = alloca %struct._composite*, align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca %struct._element*, align 8
  %11 = bitcast %struct._value* %4 to { i8, double }*
  %12 = getelementptr inbounds { i8, double }, { i8, double }* %11, i32 0, i32 0
  store i8 %0, i8* %12, align 8
  %13 = getelementptr inbounds { i8, double }, { i8, double }* %11, i32 0, i32 1
  store double %1, double* %13, align 8
  %14 = getelementptr inbounds %struct._value, %struct._value* %4, i32 0, i32 0
  %15 = load i8, i8* %14, align 8
  %16 = zext i8 %15 to i32
  %17 = icmp eq i32 %16, 4
  br i1 %17, label %18, label %28

; <label>:18:                                     ; preds = %2
  %19 = getelementptr inbounds %struct._value, %struct._value* %4, i32 0, i32 1
  %20 = bitcast double* %19 to i8**
  %21 = load i8*, i8** %20, align 8
  store i8* %21, i8** %5, align 8
  %22 = load i8*, i8** %5, align 8
  %23 = call i64 @strlen(i8* %22) #9
  store i64 %23, i64* %6, align 8
  %24 = getelementptr inbounds %struct._value, %struct._value* %3, i32 0, i32 0
  store i8 3, i8* %24, align 8
  %25 = getelementptr inbounds %struct._value, %struct._value* %3, i32 0, i32 1
  %26 = load i64, i64* %6, align 8
  %27 = uitofp i64 %26 to double
  store double %27, double* %25, align 8
  br label %68

; <label>:28:                                     ; preds = %2
  %29 = bitcast %struct._value* %4 to { i8, double }*
  %30 = getelementptr inbounds { i8, double }, { i8, double }* %29, i32 0, i32 0
  %31 = load i8, i8* %30, align 8
  %32 = getelementptr inbounds { i8, double }, { i8, double }* %29, i32 0, i32 1
  %33 = load double, double* %32, align 8
  call void @_unop_typecheck(i8* getelementptr inbounds ([1 x i8], [1 x i8]* @.str.18, i32 0, i32 0), i8 %31, double %33, i8 zeroext 6, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.31, i32 0, i32 0))
  %34 = getelementptr inbounds %struct._value, %struct._value* %4, i32 0, i32 1
  %35 = bitcast double* %34 to %struct._composite**
  %36 = load %struct._composite*, %struct._composite** %35, align 8
  store %struct._composite* %36, %struct._composite** %7, align 8
  store i32 0, i32* %8, align 4
  store i32 0, i32* %9, align 4
  br label %37

; <label>:37:                                     ; preds = %60, %28
  %38 = load i32, i32* %9, align 4
  %39 = load %struct._composite*, %struct._composite** %7, align 8
  %40 = getelementptr inbounds %struct._composite, %struct._composite* %39, i32 0, i32 0
  %41 = load i32, i32* %40, align 8
  %42 = icmp slt i32 %38, %41
  br i1 %42, label %43, label %63

; <label>:43:                                     ; preds = %37
  %44 = load %struct._composite*, %struct._composite** %7, align 8
  %45 = getelementptr inbounds %struct._composite, %struct._composite* %44, i32 0, i32 1
  %46 = load %struct._element*, %struct._element** %45, align 8
  %47 = load i32, i32* %9, align 4
  %48 = sext i32 %47 to i64
  %49 = getelementptr inbounds %struct._element, %struct._element* %46, i64 %48
  store %struct._element* %49, %struct._element** %10, align 8
  %50 = load %struct._element*, %struct._element** %10, align 8
  %51 = getelementptr inbounds %struct._element, %struct._element* %50, i32 0, i32 0
  %52 = load i32, i32* %51, align 8
  %53 = load i32, i32* %8, align 4
  %54 = icmp sgt i32 %52, %53
  br i1 %54, label %55, label %59

; <label>:55:                                     ; preds = %43
  %56 = load %struct._element*, %struct._element** %10, align 8
  %57 = getelementptr inbounds %struct._element, %struct._element* %56, i32 0, i32 0
  %58 = load i32, i32* %57, align 8
  store i32 %58, i32* %8, align 4
  br label %59

; <label>:59:                                     ; preds = %55, %43
  br label %60

; <label>:60:                                     ; preds = %59
  %61 = load i32, i32* %9, align 4
  %62 = add nsw i32 %61, 1
  store i32 %62, i32* %9, align 4
  br label %37

; <label>:63:                                     ; preds = %37
  %64 = getelementptr inbounds %struct._value, %struct._value* %3, i32 0, i32 0
  store i8 3, i8* %64, align 8
  %65 = getelementptr inbounds %struct._value, %struct._value* %3, i32 0, i32 1
  %66 = load i32, i32* %8, align 4
  %67 = sitofp i32 %66 to double
  store double %67, double* %65, align 8
  br label %68

; <label>:68:                                     ; preds = %63, %18
  %69 = bitcast %struct._value* %3 to { i8, double }*
  %70 = load { i8, double }, { i8, double }* %69, align 8
  ret { i8, double } %70
}

; Function Attrs: noinline nounwind optnone uwtable
define { i8, double } @_binop_concat(i8, double, i8, double) #0 {
  %5 = alloca %struct._value, align 8
  %6 = alloca %struct._value, align 8
  %7 = alloca %struct._value, align 8
  %8 = alloca i8*, align 8
  %9 = alloca i64, align 8
  %10 = alloca i8*, align 8
  %11 = alloca i64, align 8
  %12 = alloca i64, align 8
  %13 = alloca i8*, align 8
  %14 = alloca %struct._value, align 8
  %15 = bitcast %struct._value* %6 to { i8, double }*
  %16 = getelementptr inbounds { i8, double }, { i8, double }* %15, i32 0, i32 0
  store i8 %0, i8* %16, align 8
  %17 = getelementptr inbounds { i8, double }, { i8, double }* %15, i32 0, i32 1
  store double %1, double* %17, align 8
  %18 = bitcast %struct._value* %7 to { i8, double }*
  %19 = getelementptr inbounds { i8, double }, { i8, double }* %18, i32 0, i32 0
  store i8 %2, i8* %19, align 8
  %20 = getelementptr inbounds { i8, double }, { i8, double }* %18, i32 0, i32 1
  store double %3, double* %20, align 8
  %21 = bitcast %struct._value* %6 to { i8, double }*
  %22 = getelementptr inbounds { i8, double }, { i8, double }* %21, i32 0, i32 0
  %23 = load i8, i8* %22, align 8
  %24 = getelementptr inbounds { i8, double }, { i8, double }* %21, i32 0, i32 1
  %25 = load double, double* %24, align 8
  %26 = bitcast %struct._value* %7 to { i8, double }*
  %27 = getelementptr inbounds { i8, double }, { i8, double }* %26, i32 0, i32 0
  %28 = load i8, i8* %27, align 8
  %29 = getelementptr inbounds { i8, double }, { i8, double }* %26, i32 0, i32 1
  %30 = load double, double* %29, align 8
  call void @_binop_typecheck(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.32, i32 0, i32 0), i8 %23, double %25, i8 zeroext 4, i8 %28, double %30, i8 zeroext 4)
  %31 = getelementptr inbounds %struct._value, %struct._value* %6, i32 0, i32 1
  %32 = bitcast double* %31 to i8**
  %33 = load i8*, i8** %32, align 8
  store i8* %33, i8** %8, align 8
  %34 = getelementptr inbounds %struct._value, %struct._value* %6, i32 0, i32 1
  %35 = bitcast double* %34 to i8**
  %36 = load i8*, i8** %35, align 8
  %37 = call i64 @strlen(i8* %36) #9
  store i64 %37, i64* %9, align 8
  %38 = getelementptr inbounds %struct._value, %struct._value* %7, i32 0, i32 1
  %39 = bitcast double* %38 to i8**
  %40 = load i8*, i8** %39, align 8
  store i8* %40, i8** %10, align 8
  %41 = getelementptr inbounds %struct._value, %struct._value* %7, i32 0, i32 1
  %42 = bitcast double* %41 to i8**
  %43 = load i8*, i8** %42, align 8
  %44 = call i64 @strlen(i8* %43) #9
  store i64 %44, i64* %11, align 8
  %45 = load i64, i64* %9, align 8
  %46 = load i64, i64* %11, align 8
  %47 = add i64 %45, %46
  %48 = add i64 %47, 1
  store i64 %48, i64* %12, align 8
  %49 = load i64, i64* %9, align 8
  %50 = load i64, i64* %11, align 8
  %51 = add i64 %49, %50
  %52 = add i64 %51, 1
  %53 = call noalias i8* @calloc(i64 %52, i64 1) #2
  store i8* %53, i8** %13, align 8
  %54 = load i8*, i8** %13, align 8
  call void @_check_alloc(i8* %54)
  %55 = load i8*, i8** %13, align 8
  %56 = load i64, i64* %12, align 8
  call void @llvm.memset.p0i8.i64(i8* %55, i8 0, i64 %56, i32 1, i1 false)
  %57 = load i8*, i8** %13, align 8
  %58 = load i8*, i8** %8, align 8
  %59 = load i64, i64* %9, align 8
  %60 = call i8* @strncpy(i8* %57, i8* %58, i64 %59) #2
  %61 = load i8*, i8** %13, align 8
  %62 = load i64, i64* %9, align 8
  %63 = getelementptr inbounds i8, i8* %61, i64 %62
  %64 = load i8*, i8** %10, align 8
  %65 = load i64, i64* %11, align 8
  %66 = call i8* @strncpy(i8* %63, i8* %64, i64 %65) #2
  %67 = bitcast %struct._value* %14 to i8*
  call void @llvm.memset.p0i8.i64(i8* %67, i8 0, i64 16, i32 8, i1 false)
  %68 = getelementptr inbounds %struct._value, %struct._value* %14, i32 0, i32 0
  store i8 4, i8* %68, align 8
  %69 = getelementptr inbounds %struct._value, %struct._value* %14, i32 0, i32 1
  %70 = bitcast double* %69 to i8*
  %71 = bitcast i8** %13 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %70, i8* %71, i64 8, i32 8, i1 false)
  %72 = bitcast %struct._value* %5 to i8*
  %73 = bitcast %struct._value* %14 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %72, i8* %73, i64 16, i32 8, i1 false)
  %74 = bitcast %struct._value* %5 to { i8, double }*
  %75 = load { i8, double }, { i8, double }* %74, align 8
  ret { i8, double } %75
}

; Function Attrs: nounwind
declare i8* @strncpy(i8*, i8*, i64) #3

; Function Attrs: noinline nounwind optnone uwtable
define { i8, double } @_func_print(i8, double) #0 {
  %3 = alloca %struct._value, align 8
  %4 = alloca %struct._value, align 8
  %5 = alloca %struct._value, align 8
  %6 = alloca %struct._value, align 8
  %7 = bitcast %struct._value* %4 to { i8, double }*
  %8 = getelementptr inbounds { i8, double }, { i8, double }* %7, i32 0, i32 0
  store i8 %0, i8* %8, align 8
  %9 = getelementptr inbounds { i8, double }, { i8, double }* %7, i32 0, i32 1
  store double %1, double* %9, align 8
  %10 = getelementptr inbounds %struct._value, %struct._value* %4, i32 0, i32 0
  %11 = load i8, i8* %10, align 8
  %12 = zext i8 %11 to i32
  switch i32 %12, label %83 [
    i32 0, label %13
    i32 1, label %14
    i32 2, label %17
    i32 3, label %25
    i32 4, label %45
    i32 5, label %51
    i32 6, label %67
  ]

; <label>:13:                                     ; preds = %2
  br label %87

; <label>:14:                                     ; preds = %2
  %15 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8
  %16 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %15, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1, i32 0, i32 0))
  br label %87

; <label>:17:                                     ; preds = %2
  %18 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8
  %19 = getelementptr inbounds %struct._value, %struct._value* %4, i32 0, i32 1
  %20 = load double, double* %19, align 8
  %21 = fcmp une double %20, 0.000000e+00
  %22 = zext i1 %21 to i64
  %23 = select i1 %21, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.34, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.35, i32 0, i32 0)
  %24 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %18, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.33, i32 0, i32 0), i8* %23)
  br label %87

; <label>:25:                                     ; preds = %2
  %26 = getelementptr inbounds %struct._value, %struct._value* %4, i32 0, i32 1
  %27 = load double, double* %26, align 8
  %28 = call double @llvm.ceil.f64(double %27)
  %29 = getelementptr inbounds %struct._value, %struct._value* %4, i32 0, i32 1
  %30 = load double, double* %29, align 8
  %31 = fcmp oeq double %28, %30
  br i1 %31, label %32, label %39

; <label>:32:                                     ; preds = %25
  %33 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8
  %34 = getelementptr inbounds %struct._value, %struct._value* %4, i32 0, i32 1
  %35 = load double, double* %34, align 8
  %36 = call double @llvm.ceil.f64(double %35)
  %37 = fptosi double %36 to i64
  %38 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %33, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.36, i32 0, i32 0), i64 %37)
  br label %44

; <label>:39:                                     ; preds = %25
  %40 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8
  %41 = getelementptr inbounds %struct._value, %struct._value* %4, i32 0, i32 1
  %42 = load double, double* %41, align 8
  %43 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %40, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.37, i32 0, i32 0), double %42)
  br label %44

; <label>:44:                                     ; preds = %39, %32
  br label %87

; <label>:45:                                     ; preds = %2
  %46 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8
  %47 = getelementptr inbounds %struct._value, %struct._value* %4, i32 0, i32 1
  %48 = bitcast double* %47 to i8**
  %49 = load i8*, i8** %48, align 8
  %50 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %46, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.33, i32 0, i32 0), i8* %49)
  br label %87

; <label>:51:                                     ; preds = %2
  %52 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8
  %53 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %52, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.38, i32 0, i32 0))
  %54 = bitcast %struct._value* %4 to { i8, double }*
  %55 = getelementptr inbounds { i8, double }, { i8, double }* %54, i32 0, i32 0
  %56 = load i8, i8* %55, align 8
  %57 = getelementptr inbounds { i8, double }, { i8, double }* %54, i32 0, i32 1
  %58 = load double, double* %57, align 8
  %59 = call { i8, double } @_func_print_composite(i8 %56, double %58)
  %60 = bitcast %struct._value* %5 to { i8, double }*
  %61 = getelementptr inbounds { i8, double }, { i8, double }* %60, i32 0, i32 0
  %62 = extractvalue { i8, double } %59, 0
  store i8 %62, i8* %61, align 8
  %63 = getelementptr inbounds { i8, double }, { i8, double }* %60, i32 0, i32 1
  %64 = extractvalue { i8, double } %59, 1
  store double %64, double* %63, align 8
  %65 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8
  %66 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %65, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.39, i32 0, i32 0))
  br label %87

; <label>:67:                                     ; preds = %2
  %68 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8
  %69 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %68, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.40, i32 0, i32 0))
  %70 = bitcast %struct._value* %4 to { i8, double }*
  %71 = getelementptr inbounds { i8, double }, { i8, double }* %70, i32 0, i32 0
  %72 = load i8, i8* %71, align 8
  %73 = getelementptr inbounds { i8, double }, { i8, double }* %70, i32 0, i32 1
  %74 = load double, double* %73, align 8
  %75 = call { i8, double } @_func_print_composite(i8 %72, double %74)
  %76 = bitcast %struct._value* %6 to { i8, double }*
  %77 = getelementptr inbounds { i8, double }, { i8, double }* %76, i32 0, i32 0
  %78 = extractvalue { i8, double } %75, 0
  store i8 %78, i8* %77, align 8
  %79 = getelementptr inbounds { i8, double }, { i8, double }* %76, i32 0, i32 1
  %80 = extractvalue { i8, double } %75, 1
  store double %80, double* %79, align 8
  %81 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8
  %82 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %81, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.41, i32 0, i32 0))
  br label %87

; <label>:83:                                     ; preds = %2
  %84 = getelementptr inbounds %struct._value, %struct._value* %4, i32 0, i32 0
  %85 = load i8, i8* %84, align 8
  %86 = zext i8 %85 to i32
  call void (i32, i8*, ...) @_fatal(i32 104, i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.42, i32 0, i32 0), i32 %86)
  br label %87

; <label>:87:                                     ; preds = %83, %67, %51, %45, %44, %17, %14, %13
  %88 = bitcast %struct._value* %3 to i8*
  %89 = bitcast %struct._value* %4 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %88, i8* %89, i64 16, i32 8, i1 false)
  %90 = bitcast %struct._value* %3 to { i8, double }*
  %91 = load { i8, double }, { i8, double }* %90, align 8
  ret { i8, double } %91
}

; Function Attrs: nounwind readnone speculatable
declare double @llvm.ceil.f64(double) #7

; Function Attrs: noinline nounwind optnone uwtable
define { i8, double } @_func_print_composite(i8, double) #0 {
  %3 = alloca %struct._value, align 8
  %4 = alloca %struct._value, align 8
  %5 = alloca %struct._composite*, align 8
  %6 = alloca i32, align 4
  %7 = alloca %struct._element*, align 8
  %8 = alloca %struct._value, align 8
  %9 = bitcast %struct._value* %4 to { i8, double }*
  %10 = getelementptr inbounds { i8, double }, { i8, double }* %9, i32 0, i32 0
  store i8 %0, i8* %10, align 8
  %11 = getelementptr inbounds { i8, double }, { i8, double }* %9, i32 0, i32 1
  store double %1, double* %11, align 8
  %12 = getelementptr inbounds %struct._value, %struct._value* %4, i32 0, i32 0
  %13 = load i8, i8* %12, align 8
  %14 = zext i8 %13 to i32
  %15 = icmp ne i32 %14, 5
  br i1 %15, label %16, label %25

; <label>:16:                                     ; preds = %2
  %17 = getelementptr inbounds %struct._value, %struct._value* %4, i32 0, i32 0
  %18 = load i8, i8* %17, align 8
  %19 = zext i8 %18 to i32
  %20 = icmp ne i32 %19, 6
  br i1 %20, label %21, label %25

; <label>:21:                                     ; preds = %16
  %22 = getelementptr inbounds %struct._value, %struct._value* %4, i32 0, i32 0
  %23 = load i8, i8* %22, align 8
  %24 = call i8* @_type_str(i8 zeroext %23)
  call void (i32, i8*, ...) @_fatal(i32 101, i8* getelementptr inbounds ([29 x i8], [29 x i8]* @.str.27, i32 0, i32 0), i8* %24)
  br label %25

; <label>:25:                                     ; preds = %21, %16, %2
  %26 = getelementptr inbounds %struct._value, %struct._value* %4, i32 0, i32 1
  %27 = bitcast double* %26 to %struct._composite**
  %28 = load %struct._composite*, %struct._composite** %27, align 8
  store %struct._composite* %28, %struct._composite** %5, align 8
  store i32 0, i32* %6, align 4
  br label %29

; <label>:29:                                     ; preds = %70, %25
  %30 = load i32, i32* %6, align 4
  %31 = load %struct._composite*, %struct._composite** %5, align 8
  %32 = getelementptr inbounds %struct._composite, %struct._composite* %31, i32 0, i32 0
  %33 = load i32, i32* %32, align 8
  %34 = icmp slt i32 %30, %33
  br i1 %34, label %35, label %73

; <label>:35:                                     ; preds = %29
  %36 = load %struct._composite*, %struct._composite** %5, align 8
  %37 = getelementptr inbounds %struct._composite, %struct._composite* %36, i32 0, i32 1
  %38 = load %struct._element*, %struct._element** %37, align 8
  %39 = load i32, i32* %6, align 4
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds %struct._element, %struct._element* %38, i64 %40
  store %struct._element* %41, %struct._element** %7, align 8
  %42 = load i32, i32* %6, align 4
  %43 = icmp sgt i32 %42, 0
  br i1 %43, label %44, label %50

; <label>:44:                                     ; preds = %35
  %45 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8
  %46 = load %struct._element*, %struct._element** %7, align 8
  %47 = getelementptr inbounds %struct._element, %struct._element* %46, i32 0, i32 0
  %48 = load i32, i32* %47, align 8
  %49 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %45, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.43, i32 0, i32 0), i32 %48)
  br label %56

; <label>:50:                                     ; preds = %35
  %51 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8
  %52 = load %struct._element*, %struct._element** %7, align 8
  %53 = getelementptr inbounds %struct._element, %struct._element* %52, i32 0, i32 0
  %54 = load i32, i32* %53, align 8
  %55 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %51, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.44, i32 0, i32 0), i32 %54)
  br label %56

; <label>:56:                                     ; preds = %50, %44
  %57 = load %struct._element*, %struct._element** %7, align 8
  %58 = getelementptr inbounds %struct._element, %struct._element* %57, i32 0, i32 1
  %59 = bitcast %struct._value* %58 to { i8, double }*
  %60 = getelementptr inbounds { i8, double }, { i8, double }* %59, i32 0, i32 0
  %61 = load i8, i8* %60, align 8
  %62 = getelementptr inbounds { i8, double }, { i8, double }* %59, i32 0, i32 1
  %63 = load double, double* %62, align 8
  %64 = call { i8, double } @_func_print(i8 %61, double %63)
  %65 = bitcast %struct._value* %8 to { i8, double }*
  %66 = getelementptr inbounds { i8, double }, { i8, double }* %65, i32 0, i32 0
  %67 = extractvalue { i8, double } %64, 0
  store i8 %67, i8* %66, align 8
  %68 = getelementptr inbounds { i8, double }, { i8, double }* %65, i32 0, i32 1
  %69 = extractvalue { i8, double } %64, 1
  store double %69, double* %68, align 8
  br label %70

; <label>:70:                                     ; preds = %56
  %71 = load i32, i32* %6, align 4
  %72 = add nsw i32 %71, 1
  store i32 %72, i32* %6, align 4
  br label %29

; <label>:73:                                     ; preds = %29
  %74 = bitcast %struct._value* %3 to i8*
  %75 = bitcast %struct._value* %4 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %74, i8* %75, i64 16, i32 8, i1 false)
  %76 = bitcast %struct._value* %3 to { i8, double }*
  %77 = load { i8, double }, { i8, double }* %76, align 8
  ret { i8, double } %77
}

; Function Attrs: noinline nounwind optnone uwtable
define { i8, double } @_func_assert(i8, double, i8, double) #0 {
  %5 = alloca %struct._value, align 8
  %6 = alloca %struct._value, align 8
  %7 = alloca %struct._value, align 8
  %8 = alloca i8*, align 8
  %9 = bitcast %struct._value* %6 to { i8, double }*
  %10 = getelementptr inbounds { i8, double }, { i8, double }* %9, i32 0, i32 0
  store i8 %0, i8* %10, align 8
  %11 = getelementptr inbounds { i8, double }, { i8, double }* %9, i32 0, i32 1
  store double %1, double* %11, align 8
  %12 = bitcast %struct._value* %7 to { i8, double }*
  %13 = getelementptr inbounds { i8, double }, { i8, double }* %12, i32 0, i32 0
  store i8 %2, i8* %13, align 8
  %14 = getelementptr inbounds { i8, double }, { i8, double }* %12, i32 0, i32 1
  store double %3, double* %14, align 8
  %15 = getelementptr inbounds %struct._value, %struct._value* %6, i32 0, i32 0
  %16 = load i8, i8* %15, align 8
  %17 = zext i8 %16 to i32
  %18 = icmp ne i32 %17, 2
  br i1 %18, label %23, label %19

; <label>:19:                                     ; preds = %4
  %20 = getelementptr inbounds %struct._value, %struct._value* %6, i32 0, i32 1
  %21 = load double, double* %20, align 8
  %22 = fcmp une double %21, 0.000000e+00
  br i1 %22, label %36, label %23

; <label>:23:                                     ; preds = %19, %4
  %24 = getelementptr inbounds %struct._value, %struct._value* %7, i32 0, i32 0
  %25 = load i8, i8* %24, align 8
  %26 = zext i8 %25 to i32
  %27 = icmp eq i32 %26, 4
  br i1 %27, label %28, label %32

; <label>:28:                                     ; preds = %23
  %29 = getelementptr inbounds %struct._value, %struct._value* %7, i32 0, i32 1
  %30 = bitcast double* %29 to i8**
  %31 = load i8*, i8** %30, align 8
  br label %33

; <label>:32:                                     ; preds = %23
  br label %33

; <label>:33:                                     ; preds = %32, %28
  %34 = phi i8* [ %31, %28 ], [ getelementptr inbounds ([12 x i8], [12 x i8]* @.str.45, i32 0, i32 0), %32 ]
  store i8* %34, i8** %8, align 8
  %35 = load i8*, i8** %8, align 8
  call void (i32, i8*, ...) @_fatal(i32 105, i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.46, i32 0, i32 0), i8* %35)
  br label %36

; <label>:36:                                     ; preds = %33, %19
  %37 = bitcast %struct._value* %5 to i8*
  %38 = bitcast %struct._value* %6 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %37, i8* %38, i64 16, i32 8, i1 false)
  %39 = bitcast %struct._value* %5 to { i8, double }*
  %40 = load { i8, double }, { i8, double }* %39, align 8
  ret { i8, double } %40
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main(i32, i8**) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i8**, align 8
  %6 = alloca %struct._value, align 8
  %7 = alloca %struct._value, align 8
  %8 = alloca %struct._value, align 8
  store i32 0, i32* %3, align 4
  store i32 %0, i32* %4, align 4
  store i8** %1, i8*** %5, align 8
  %9 = getelementptr inbounds %struct._value, %struct._value* %6, i32 0, i32 0
  store i8 1, i8* %9, align 8
  %10 = getelementptr inbounds %struct._value, %struct._value* %6, i32 0, i32 0
  store i8 0, i8* %10, align 8
  %11 = bitcast %struct._value* %6 to { i8, double }*
  %12 = getelementptr inbounds { i8, double }, { i8, double }* %11, i32 0, i32 0
  %13 = load i8, i8* %12, align 8
  %14 = getelementptr inbounds { i8, double }, { i8, double }* %11, i32 0, i32 1
  %15 = load double, double* %14, align 8
  %16 = call { i8, double } @jijo(i8 %13, double %15)
  %17 = bitcast %struct._value* %7 to { i8, double }*
  %18 = getelementptr inbounds { i8, double }, { i8, double }* %17, i32 0, i32 0
  %19 = extractvalue { i8, double } %16, 0
  store i8 %19, i8* %18, align 8
  %20 = getelementptr inbounds { i8, double }, { i8, double }* %17, i32 0, i32 1
  %21 = extractvalue { i8, double } %16, 1
  store double %21, double* %20, align 8
  %22 = bitcast %struct._value* %7 to { i8, double }*
  %23 = getelementptr inbounds { i8, double }, { i8, double }* %22, i32 0, i32 0
  %24 = load i8, i8* %23, align 8
  %25 = getelementptr inbounds { i8, double }, { i8, double }* %22, i32 0, i32 1
  %26 = load double, double* %25, align 8
  %27 = call { i8, double } @_func_print(i8 %24, double %26)
  %28 = bitcast %struct._value* %8 to { i8, double }*
  %29 = getelementptr inbounds { i8, double }, { i8, double }* %28, i32 0, i32 0
  %30 = extractvalue { i8, double } %27, 0
  store i8 %30, i8* %29, align 8
  %31 = getelementptr inbounds { i8, double }, { i8, double }* %28, i32 0, i32 1
  %32 = extractvalue { i8, double } %27, 1
  store double %32, double* %31, align 8
  %33 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8
  %34 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %33, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.9, i32 0, i32 0))
  ret i32 0
}

declare { i8, double } @jijo(i8, double) #1

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { argmemonly nounwind }
attributes #6 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { nounwind readnone speculatable }
attributes #8 = { noreturn nounwind }
attributes #9 = { nounwind readonly }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 6.0.1-svn334776-1~exp1~20190309042704.123 (branches/release_60)"}

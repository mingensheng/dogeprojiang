; ModuleID = 'point_struct.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.foo = type { i32, i32 }

@.str = private unnamed_addr constant [4 x i8] c"foo\00", align 1
@.str1 = private unnamed_addr constant [12 x i8] c"klee_choose\00", align 1
@.str12 = private unnamed_addr constant [22 x i8] c"klee_div_zero_check.c\00", align 1
@.str123 = private unnamed_addr constant [15 x i8] c"divide by zero\00", align 1
@.str2 = private unnamed_addr constant [8 x i8] c"div.err\00", align 1
@.str3 = private unnamed_addr constant [8 x i8] c"IGNORED\00", align 1
@.str14 = private unnamed_addr constant [16 x i8] c"overshift error\00", align 1
@.str25 = private unnamed_addr constant [14 x i8] c"overshift.err\00", align 1
@.str6 = private unnamed_addr constant [13 x i8] c"klee_range.c\00", align 1
@.str17 = private unnamed_addr constant [14 x i8] c"invalid range\00", align 1
@.str28 = private unnamed_addr constant [5 x i8] c"user\00", align 1

; Function Attrs: nounwind uwtable
define i32 @bar(i8* %foo_ptr) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i8*, align 8
  %foo_ptr_temp = alloca %struct.foo*, align 8
  store i8* %foo_ptr, i8** %2, align 8
  %3 = load i8** %2, align 8, !dbg !143
  %4 = bitcast i8* %3 to %struct.foo*, !dbg !143
  store %struct.foo* %4, %struct.foo** %foo_ptr_temp, align 8, !dbg !143
  %5 = load %struct.foo** %foo_ptr_temp, align 8, !dbg !144
  %6 = getelementptr inbounds %struct.foo* %5, i32 0, i32 0, !dbg !144
  %7 = load i32* %6, align 4, !dbg !144
  %8 = icmp eq i32 %7, 1, !dbg !144
  br i1 %8, label %9, label %10, !dbg !144

; <label>:9                                       ; preds = %0
  store i32 1, i32* %1, !dbg !146
  br label %11, !dbg !146

; <label>:10                                      ; preds = %0
  store i32 2, i32* %1, !dbg !148
  br label %11, !dbg !148

; <label>:11                                      ; preds = %10, %9
  %12 = load i32* %1, !dbg !150
  ret i32 %12, !dbg !150
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata) #1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %foo_ptr = alloca %struct.foo*, align 8
  store i32 0, i32* %1
  %2 = call noalias i8* @malloc(i64 8) #7, !dbg !151
  %3 = bitcast i8* %2 to %struct.foo*, !dbg !151
  store %struct.foo* %3, %struct.foo** %foo_ptr, align 8, !dbg !151
  %4 = load %struct.foo** %foo_ptr, align 8, !dbg !152
  %5 = bitcast %struct.foo* %4 to i8*, !dbg !152
  %6 = load %struct.foo** %foo_ptr, align 8, !dbg !153
  %7 = bitcast %struct.foo* %6 to i8*, !dbg !153
  call void @klee_make_symbolic(i8* %7, i64 8, i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0)), !dbg !153
  %8 = load %struct.foo** %foo_ptr, align 8, !dbg !154
  %9 = bitcast %struct.foo* %8 to i8*, !dbg !154
  %10 = call i32 @bar(i8* %9), !dbg !154
  ret i32 %10, !dbg !154
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #2

declare void @klee_make_symbolic(i8*, i64, i8*) #3

; Function Attrs: nounwind ssp uwtable
define i64 @klee_choose(i64 %n) #4 {
  %x = alloca i64, align 8
  %1 = bitcast i64* %x to i8*, !dbg !155
  call void @klee_make_symbolic(i8* %1, i64 8, i8* getelementptr inbounds ([12 x i8]* @.str1, i64 0, i64 0)) #8, !dbg !155
  %2 = load i64* %x, align 8, !dbg !156, !tbaa !158
  %3 = icmp ult i64 %2, %n, !dbg !156
  br i1 %3, label %5, label %4, !dbg !156

; <label>:4                                       ; preds = %0
  call void @klee_silent_exit(i32 0) #9, !dbg !162
  unreachable, !dbg !162

; <label>:5                                       ; preds = %0
  ret i64 %2, !dbg !163
}

; Function Attrs: noreturn
declare void @klee_silent_exit(i32) #5

; Function Attrs: nounwind readnone
declare void @llvm.dbg.value(metadata, i64, metadata) #1

; Function Attrs: nounwind ssp uwtable
define void @klee_div_zero_check(i64 %z) #4 {
  %1 = icmp eq i64 %z, 0, !dbg !164
  br i1 %1, label %2, label %3, !dbg !164

; <label>:2                                       ; preds = %0
  tail call void @klee_report_error(i8* getelementptr inbounds ([22 x i8]* @.str12, i64 0, i64 0), i32 14, i8* getelementptr inbounds ([15 x i8]* @.str123, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str2, i64 0, i64 0)) #9, !dbg !166
  unreachable, !dbg !166

; <label>:3                                       ; preds = %0
  ret void, !dbg !167
}

; Function Attrs: noreturn
declare void @klee_report_error(i8*, i32, i8*, i8*) #5

; Function Attrs: nounwind ssp uwtable
define i32 @klee_int(i8* %name) #4 {
  %x = alloca i32, align 4
  %1 = bitcast i32* %x to i8*, !dbg !168
  call void @klee_make_symbolic(i8* %1, i64 4, i8* %name) #8, !dbg !168
  %2 = load i32* %x, align 4, !dbg !169, !tbaa !170
  ret i32 %2, !dbg !169
}

; Function Attrs: nounwind ssp uwtable
define void @klee_overshift_check(i64 %bitWidth, i64 %shift) #4 {
  %1 = icmp ult i64 %shift, %bitWidth, !dbg !172
  br i1 %1, label %3, label %2, !dbg !172

; <label>:2                                       ; preds = %0
  tail call void @klee_report_error(i8* getelementptr inbounds ([8 x i8]* @.str3, i64 0, i64 0), i32 0, i8* getelementptr inbounds ([16 x i8]* @.str14, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8]* @.str25, i64 0, i64 0)) #9, !dbg !174
  unreachable, !dbg !174

; <label>:3                                       ; preds = %0
  ret void, !dbg !176
}

; Function Attrs: nounwind ssp uwtable
define i32 @klee_range(i32 %start, i32 %end, i8* %name) #4 {
  %x = alloca i32, align 4
  %1 = icmp slt i32 %start, %end, !dbg !177
  br i1 %1, label %3, label %2, !dbg !177

; <label>:2                                       ; preds = %0
  call void @klee_report_error(i8* getelementptr inbounds ([13 x i8]* @.str6, i64 0, i64 0), i32 17, i8* getelementptr inbounds ([14 x i8]* @.str17, i64 0, i64 0), i8* getelementptr inbounds ([5 x i8]* @.str28, i64 0, i64 0)) #9, !dbg !179
  unreachable, !dbg !179

; <label>:3                                       ; preds = %0
  %4 = add nsw i32 %start, 1, !dbg !180
  %5 = icmp eq i32 %4, %end, !dbg !180
  br i1 %5, label %21, label %6, !dbg !180

; <label>:6                                       ; preds = %3
  %7 = bitcast i32* %x to i8*, !dbg !182
  call void @klee_make_symbolic(i8* %7, i64 4, i8* %name) #8, !dbg !182
  %8 = icmp eq i32 %start, 0, !dbg !184
  %9 = load i32* %x, align 4, !dbg !186, !tbaa !170
  br i1 %8, label %10, label %13, !dbg !184

; <label>:10                                      ; preds = %6
  %11 = icmp ult i32 %9, %end, !dbg !186
  %12 = zext i1 %11 to i64, !dbg !186
  call void @klee_assume(i64 %12) #8, !dbg !186
  br label %19, !dbg !188

; <label>:13                                      ; preds = %6
  %14 = icmp sge i32 %9, %start, !dbg !189
  %15 = zext i1 %14 to i64, !dbg !189
  call void @klee_assume(i64 %15) #8, !dbg !189
  %16 = load i32* %x, align 4, !dbg !191, !tbaa !170
  %17 = icmp slt i32 %16, %end, !dbg !191
  %18 = zext i1 %17 to i64, !dbg !191
  call void @klee_assume(i64 %18) #8, !dbg !191
  br label %19

; <label>:19                                      ; preds = %13, %10
  %20 = load i32* %x, align 4, !dbg !192, !tbaa !170
  br label %21, !dbg !192

; <label>:21                                      ; preds = %19, %3
  %.0 = phi i32 [ %20, %19 ], [ %start, %3 ]
  ret i32 %.0, !dbg !193
}

declare void @klee_assume(i64) #6

; Function Attrs: nounwind ssp uwtable
define weak i8* @memcpy(i8* %destaddr, i8* %srcaddr, i64 %len) #4 {
  %1 = icmp eq i64 %len, 0, !dbg !194
  br i1 %1, label %._crit_edge, label %.lr.ph.preheader, !dbg !194

.lr.ph.preheader:                                 ; preds = %0
  %n.vec = and i64 %len, -32
  %cmp.zero = icmp eq i64 %n.vec, 0
  %2 = add i64 %len, -1
  br i1 %cmp.zero, label %middle.block, label %vector.memcheck

vector.memcheck:                                  ; preds = %.lr.ph.preheader
  %scevgep4 = getelementptr i8* %srcaddr, i64 %2
  %scevgep = getelementptr i8* %destaddr, i64 %2
  %bound1 = icmp uge i8* %scevgep, %srcaddr
  %bound0 = icmp uge i8* %scevgep4, %destaddr
  %memcheck.conflict = and i1 %bound0, %bound1
  %ptr.ind.end = getelementptr i8* %srcaddr, i64 %n.vec
  %ptr.ind.end6 = getelementptr i8* %destaddr, i64 %n.vec
  %rev.ind.end = sub i64 %len, %n.vec
  br i1 %memcheck.conflict, label %middle.block, label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.memcheck
  %index = phi i64 [ %index.next, %vector.body ], [ 0, %vector.memcheck ]
  %next.gep = getelementptr i8* %srcaddr, i64 %index
  %next.gep103 = getelementptr i8* %destaddr, i64 %index
  %3 = bitcast i8* %next.gep to <16 x i8>*, !dbg !195
  %wide.load = load <16 x i8>* %3, align 1, !dbg !195
  %next.gep.sum279 = or i64 %index, 16, !dbg !195
  %4 = getelementptr i8* %srcaddr, i64 %next.gep.sum279, !dbg !195
  %5 = bitcast i8* %4 to <16 x i8>*, !dbg !195
  %wide.load200 = load <16 x i8>* %5, align 1, !dbg !195
  %6 = bitcast i8* %next.gep103 to <16 x i8>*, !dbg !195
  store <16 x i8> %wide.load, <16 x i8>* %6, align 1, !dbg !195
  %7 = getelementptr i8* %destaddr, i64 %next.gep.sum279, !dbg !195
  %8 = bitcast i8* %7 to <16 x i8>*, !dbg !195
  store <16 x i8> %wide.load200, <16 x i8>* %8, align 1, !dbg !195
  %index.next = add i64 %index, 32
  %9 = icmp eq i64 %index.next, %n.vec
  br i1 %9, label %middle.block, label %vector.body, !llvm.loop !196

middle.block:                                     ; preds = %vector.body, %vector.memcheck, %.lr.ph.preheader
  %resume.val = phi i8* [ %srcaddr, %.lr.ph.preheader ], [ %srcaddr, %vector.memcheck ], [ %ptr.ind.end, %vector.body ]
  %resume.val5 = phi i8* [ %destaddr, %.lr.ph.preheader ], [ %destaddr, %vector.memcheck ], [ %ptr.ind.end6, %vector.body ]
  %resume.val7 = phi i64 [ %len, %.lr.ph.preheader ], [ %len, %vector.memcheck ], [ %rev.ind.end, %vector.body ]
  %new.indc.resume.val = phi i64 [ 0, %.lr.ph.preheader ], [ 0, %vector.memcheck ], [ %n.vec, %vector.body ]
  %cmp.n = icmp eq i64 %new.indc.resume.val, %len
  br i1 %cmp.n, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph, %middle.block
  %src.03 = phi i8* [ %11, %.lr.ph ], [ %resume.val, %middle.block ]
  %dest.02 = phi i8* [ %13, %.lr.ph ], [ %resume.val5, %middle.block ]
  %.01 = phi i64 [ %10, %.lr.ph ], [ %resume.val7, %middle.block ]
  %10 = add i64 %.01, -1, !dbg !194
  %11 = getelementptr inbounds i8* %src.03, i64 1, !dbg !195
  %12 = load i8* %src.03, align 1, !dbg !195, !tbaa !199
  %13 = getelementptr inbounds i8* %dest.02, i64 1, !dbg !195
  store i8 %12, i8* %dest.02, align 1, !dbg !195, !tbaa !199
  %14 = icmp eq i64 %10, 0, !dbg !194
  br i1 %14, label %._crit_edge, label %.lr.ph, !dbg !194, !llvm.loop !200

._crit_edge:                                      ; preds = %.lr.ph, %middle.block, %0
  ret i8* %destaddr, !dbg !201
}

; Function Attrs: nounwind ssp uwtable
define weak i8* @memmove(i8* %dst, i8* %src, i64 %count) #4 {
  %1 = icmp eq i8* %src, %dst, !dbg !202
  br i1 %1, label %.loopexit, label %2, !dbg !202

; <label>:2                                       ; preds = %0
  %3 = icmp ugt i8* %src, %dst, !dbg !204
  br i1 %3, label %.preheader, label %18, !dbg !204

.preheader:                                       ; preds = %2
  %4 = icmp eq i64 %count, 0, !dbg !206
  br i1 %4, label %.loopexit, label %.lr.ph.preheader, !dbg !206

.lr.ph.preheader:                                 ; preds = %.preheader
  %n.vec = and i64 %count, -32
  %cmp.zero = icmp eq i64 %n.vec, 0
  %5 = add i64 %count, -1
  br i1 %cmp.zero, label %middle.block, label %vector.memcheck

vector.memcheck:                                  ; preds = %.lr.ph.preheader
  %scevgep11 = getelementptr i8* %src, i64 %5
  %scevgep = getelementptr i8* %dst, i64 %5
  %bound1 = icmp uge i8* %scevgep, %src
  %bound0 = icmp uge i8* %scevgep11, %dst
  %memcheck.conflict = and i1 %bound0, %bound1
  %ptr.ind.end = getelementptr i8* %src, i64 %n.vec
  %ptr.ind.end13 = getelementptr i8* %dst, i64 %n.vec
  %rev.ind.end = sub i64 %count, %n.vec
  br i1 %memcheck.conflict, label %middle.block, label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.memcheck
  %index = phi i64 [ %index.next, %vector.body ], [ 0, %vector.memcheck ]
  %next.gep = getelementptr i8* %src, i64 %index
  %next.gep110 = getelementptr i8* %dst, i64 %index
  %6 = bitcast i8* %next.gep to <16 x i8>*, !dbg !206
  %wide.load = load <16 x i8>* %6, align 1, !dbg !206
  %next.gep.sum586 = or i64 %index, 16, !dbg !206
  %7 = getelementptr i8* %src, i64 %next.gep.sum586, !dbg !206
  %8 = bitcast i8* %7 to <16 x i8>*, !dbg !206
  %wide.load207 = load <16 x i8>* %8, align 1, !dbg !206
  %9 = bitcast i8* %next.gep110 to <16 x i8>*, !dbg !206
  store <16 x i8> %wide.load, <16 x i8>* %9, align 1, !dbg !206
  %10 = getelementptr i8* %dst, i64 %next.gep.sum586, !dbg !206
  %11 = bitcast i8* %10 to <16 x i8>*, !dbg !206
  store <16 x i8> %wide.load207, <16 x i8>* %11, align 1, !dbg !206
  %index.next = add i64 %index, 32
  %12 = icmp eq i64 %index.next, %n.vec
  br i1 %12, label %middle.block, label %vector.body, !llvm.loop !208

middle.block:                                     ; preds = %vector.body, %vector.memcheck, %.lr.ph.preheader
  %resume.val = phi i8* [ %src, %.lr.ph.preheader ], [ %src, %vector.memcheck ], [ %ptr.ind.end, %vector.body ]
  %resume.val12 = phi i8* [ %dst, %.lr.ph.preheader ], [ %dst, %vector.memcheck ], [ %ptr.ind.end13, %vector.body ]
  %resume.val14 = phi i64 [ %count, %.lr.ph.preheader ], [ %count, %vector.memcheck ], [ %rev.ind.end, %vector.body ]
  %new.indc.resume.val = phi i64 [ 0, %.lr.ph.preheader ], [ 0, %vector.memcheck ], [ %n.vec, %vector.body ]
  %cmp.n = icmp eq i64 %new.indc.resume.val, %count
  br i1 %cmp.n, label %.loopexit, label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph, %middle.block
  %b.04 = phi i8* [ %14, %.lr.ph ], [ %resume.val, %middle.block ]
  %a.03 = phi i8* [ %16, %.lr.ph ], [ %resume.val12, %middle.block ]
  %.02 = phi i64 [ %13, %.lr.ph ], [ %resume.val14, %middle.block ]
  %13 = add i64 %.02, -1, !dbg !206
  %14 = getelementptr inbounds i8* %b.04, i64 1, !dbg !206
  %15 = load i8* %b.04, align 1, !dbg !206, !tbaa !199
  %16 = getelementptr inbounds i8* %a.03, i64 1, !dbg !206
  store i8 %15, i8* %a.03, align 1, !dbg !206, !tbaa !199
  %17 = icmp eq i64 %13, 0, !dbg !206
  br i1 %17, label %.loopexit, label %.lr.ph, !dbg !206, !llvm.loop !209

; <label>:18                                      ; preds = %2
  %19 = add i64 %count, -1, !dbg !210
  %20 = icmp eq i64 %count, 0, !dbg !212
  br i1 %20, label %.loopexit, label %.lr.ph9, !dbg !212

.lr.ph9:                                          ; preds = %18
  %21 = getelementptr inbounds i8* %src, i64 %19, !dbg !213
  %22 = getelementptr inbounds i8* %dst, i64 %19, !dbg !210
  %n.vec215 = and i64 %count, -32
  %cmp.zero217 = icmp eq i64 %n.vec215, 0
  br i1 %cmp.zero217, label %middle.block210, label %vector.memcheck224

vector.memcheck224:                               ; preds = %.lr.ph9
  %bound1221 = icmp ule i8* %21, %dst
  %bound0220 = icmp ule i8* %22, %src
  %memcheck.conflict223 = and i1 %bound0220, %bound1221
  %.sum = sub i64 %19, %n.vec215
  %rev.ptr.ind.end = getelementptr i8* %src, i64 %.sum
  %rev.ptr.ind.end229 = getelementptr i8* %dst, i64 %.sum
  %rev.ind.end231 = sub i64 %count, %n.vec215
  br i1 %memcheck.conflict223, label %middle.block210, label %vector.body209

vector.body209:                                   ; preds = %vector.body209, %vector.memcheck224
  %index212 = phi i64 [ %index.next234, %vector.body209 ], [ 0, %vector.memcheck224 ]
  %.sum440 = sub i64 %19, %index212
  %next.gep236.sum = add i64 %.sum440, -15, !dbg !212
  %23 = getelementptr i8* %src, i64 %next.gep236.sum, !dbg !212
  %24 = bitcast i8* %23 to <16 x i8>*, !dbg !212
  %wide.load434 = load <16 x i8>* %24, align 1, !dbg !212
  %reverse = shufflevector <16 x i8> %wide.load434, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>, !dbg !212
  %.sum505 = add i64 %.sum440, -31, !dbg !212
  %25 = getelementptr i8* %src, i64 %.sum505, !dbg !212
  %26 = bitcast i8* %25 to <16 x i8>*, !dbg !212
  %wide.load435 = load <16 x i8>* %26, align 1, !dbg !212
  %reverse436 = shufflevector <16 x i8> %wide.load435, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>, !dbg !212
  %reverse437 = shufflevector <16 x i8> %reverse, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>, !dbg !212
  %27 = getelementptr i8* %dst, i64 %next.gep236.sum, !dbg !212
  %28 = bitcast i8* %27 to <16 x i8>*, !dbg !212
  store <16 x i8> %reverse437, <16 x i8>* %28, align 1, !dbg !212
  %reverse438 = shufflevector <16 x i8> %reverse436, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>, !dbg !212
  %29 = getelementptr i8* %dst, i64 %.sum505, !dbg !212
  %30 = bitcast i8* %29 to <16 x i8>*, !dbg !212
  store <16 x i8> %reverse438, <16 x i8>* %30, align 1, !dbg !212
  %index.next234 = add i64 %index212, 32
  %31 = icmp eq i64 %index.next234, %n.vec215
  br i1 %31, label %middle.block210, label %vector.body209, !llvm.loop !214

middle.block210:                                  ; preds = %vector.body209, %vector.memcheck224, %.lr.ph9
  %resume.val225 = phi i8* [ %21, %.lr.ph9 ], [ %21, %vector.memcheck224 ], [ %rev.ptr.ind.end, %vector.body209 ]
  %resume.val227 = phi i8* [ %22, %.lr.ph9 ], [ %22, %vector.memcheck224 ], [ %rev.ptr.ind.end229, %vector.body209 ]
  %resume.val230 = phi i64 [ %count, %.lr.ph9 ], [ %count, %vector.memcheck224 ], [ %rev.ind.end231, %vector.body209 ]
  %new.indc.resume.val232 = phi i64 [ 0, %.lr.ph9 ], [ 0, %vector.memcheck224 ], [ %n.vec215, %vector.body209 ]
  %cmp.n233 = icmp eq i64 %new.indc.resume.val232, %count
  br i1 %cmp.n233, label %.loopexit, label %scalar.ph211

scalar.ph211:                                     ; preds = %scalar.ph211, %middle.block210
  %b.18 = phi i8* [ %33, %scalar.ph211 ], [ %resume.val225, %middle.block210 ]
  %a.17 = phi i8* [ %35, %scalar.ph211 ], [ %resume.val227, %middle.block210 ]
  %.16 = phi i64 [ %32, %scalar.ph211 ], [ %resume.val230, %middle.block210 ]
  %32 = add i64 %.16, -1, !dbg !212
  %33 = getelementptr inbounds i8* %b.18, i64 -1, !dbg !212
  %34 = load i8* %b.18, align 1, !dbg !212, !tbaa !199
  %35 = getelementptr inbounds i8* %a.17, i64 -1, !dbg !212
  store i8 %34, i8* %a.17, align 1, !dbg !212, !tbaa !199
  %36 = icmp eq i64 %32, 0, !dbg !212
  br i1 %36, label %.loopexit, label %scalar.ph211, !dbg !212, !llvm.loop !215

.loopexit:                                        ; preds = %scalar.ph211, %middle.block210, %18, %.lr.ph, %middle.block, %.preheader, %0
  ret i8* %dst, !dbg !216
}

; Function Attrs: nounwind ssp uwtable
define weak i8* @mempcpy(i8* %destaddr, i8* %srcaddr, i64 %len) #4 {
  %1 = icmp eq i64 %len, 0, !dbg !217
  br i1 %1, label %15, label %.lr.ph.preheader, !dbg !217

.lr.ph.preheader:                                 ; preds = %0
  %n.vec = and i64 %len, -32
  %cmp.zero = icmp eq i64 %n.vec, 0
  %2 = add i64 %len, -1
  br i1 %cmp.zero, label %middle.block, label %vector.memcheck

vector.memcheck:                                  ; preds = %.lr.ph.preheader
  %scevgep5 = getelementptr i8* %srcaddr, i64 %2
  %scevgep4 = getelementptr i8* %destaddr, i64 %2
  %bound1 = icmp uge i8* %scevgep4, %srcaddr
  %bound0 = icmp uge i8* %scevgep5, %destaddr
  %memcheck.conflict = and i1 %bound0, %bound1
  %ptr.ind.end = getelementptr i8* %srcaddr, i64 %n.vec
  %ptr.ind.end7 = getelementptr i8* %destaddr, i64 %n.vec
  %rev.ind.end = sub i64 %len, %n.vec
  br i1 %memcheck.conflict, label %middle.block, label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.memcheck
  %index = phi i64 [ %index.next, %vector.body ], [ 0, %vector.memcheck ]
  %next.gep = getelementptr i8* %srcaddr, i64 %index
  %next.gep104 = getelementptr i8* %destaddr, i64 %index
  %3 = bitcast i8* %next.gep to <16 x i8>*, !dbg !218
  %wide.load = load <16 x i8>* %3, align 1, !dbg !218
  %next.gep.sum280 = or i64 %index, 16, !dbg !218
  %4 = getelementptr i8* %srcaddr, i64 %next.gep.sum280, !dbg !218
  %5 = bitcast i8* %4 to <16 x i8>*, !dbg !218
  %wide.load201 = load <16 x i8>* %5, align 1, !dbg !218
  %6 = bitcast i8* %next.gep104 to <16 x i8>*, !dbg !218
  store <16 x i8> %wide.load, <16 x i8>* %6, align 1, !dbg !218
  %7 = getelementptr i8* %destaddr, i64 %next.gep.sum280, !dbg !218
  %8 = bitcast i8* %7 to <16 x i8>*, !dbg !218
  store <16 x i8> %wide.load201, <16 x i8>* %8, align 1, !dbg !218
  %index.next = add i64 %index, 32
  %9 = icmp eq i64 %index.next, %n.vec
  br i1 %9, label %middle.block, label %vector.body, !llvm.loop !219

middle.block:                                     ; preds = %vector.body, %vector.memcheck, %.lr.ph.preheader
  %resume.val = phi i8* [ %srcaddr, %.lr.ph.preheader ], [ %srcaddr, %vector.memcheck ], [ %ptr.ind.end, %vector.body ]
  %resume.val6 = phi i8* [ %destaddr, %.lr.ph.preheader ], [ %destaddr, %vector.memcheck ], [ %ptr.ind.end7, %vector.body ]
  %resume.val8 = phi i64 [ %len, %.lr.ph.preheader ], [ %len, %vector.memcheck ], [ %rev.ind.end, %vector.body ]
  %new.indc.resume.val = phi i64 [ 0, %.lr.ph.preheader ], [ 0, %vector.memcheck ], [ %n.vec, %vector.body ]
  %cmp.n = icmp eq i64 %new.indc.resume.val, %len
  br i1 %cmp.n, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph, %middle.block
  %src.03 = phi i8* [ %11, %.lr.ph ], [ %resume.val, %middle.block ]
  %dest.02 = phi i8* [ %13, %.lr.ph ], [ %resume.val6, %middle.block ]
  %.01 = phi i64 [ %10, %.lr.ph ], [ %resume.val8, %middle.block ]
  %10 = add i64 %.01, -1, !dbg !217
  %11 = getelementptr inbounds i8* %src.03, i64 1, !dbg !218
  %12 = load i8* %src.03, align 1, !dbg !218, !tbaa !199
  %13 = getelementptr inbounds i8* %dest.02, i64 1, !dbg !218
  store i8 %12, i8* %dest.02, align 1, !dbg !218, !tbaa !199
  %14 = icmp eq i64 %10, 0, !dbg !217
  br i1 %14, label %._crit_edge, label %.lr.ph, !dbg !217, !llvm.loop !220

._crit_edge:                                      ; preds = %.lr.ph, %middle.block
  %scevgep = getelementptr i8* %destaddr, i64 %len
  br label %15, !dbg !217

; <label>:15                                      ; preds = %._crit_edge, %0
  %dest.0.lcssa = phi i8* [ %scevgep, %._crit_edge ], [ %destaddr, %0 ]
  ret i8* %dest.0.lcssa, !dbg !221
}

; Function Attrs: nounwind ssp uwtable
define weak i8* @memset(i8* %dst, i32 %s, i64 %count) #4 {
  %1 = icmp eq i64 %count, 0, !dbg !222
  br i1 %1, label %._crit_edge, label %.lr.ph, !dbg !222

.lr.ph:                                           ; preds = %0
  %2 = trunc i32 %s to i8, !dbg !223
  br label %3, !dbg !222

; <label>:3                                       ; preds = %3, %.lr.ph
  %a.02 = phi i8* [ %dst, %.lr.ph ], [ %5, %3 ]
  %.01 = phi i64 [ %count, %.lr.ph ], [ %4, %3 ]
  %4 = add i64 %.01, -1, !dbg !222
  %5 = getelementptr inbounds i8* %a.02, i64 1, !dbg !223
  store volatile i8 %2, i8* %a.02, align 1, !dbg !223, !tbaa !199
  %6 = icmp eq i64 %4, 0, !dbg !222
  br i1 %6, label %._crit_edge, label %3, !dbg !222

._crit_edge:                                      ; preds = %3, %0
  ret i8* %dst, !dbg !224
}

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float
attributes #1 = { nounwind readnone }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false
attributes #3 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind ssp uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="4" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { noreturn "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="4" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="4" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { nounwind }
attributes #8 = { nobuiltin nounwind }
attributes #9 = { nobuiltin noreturn nounwind }

!llvm.dbg.cu = !{!0, !13, !26, !37, !51, !63, !76, !94, !109, !124}
!llvm.module.flags = !{!140, !141}
!llvm.ident = !{!142, !142, !142, !142, !142, !142, !142, !142, !142, !142}

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !""} ; [ DW_TAG
!1 = metadata !{metadata !"point_struct.c", metadata !"/home/ubuntu/test_cast"}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4, metadata !10}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"bar", metadata !"bar", metadata !"", i32 10, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (i8*)* @bar, null, null, metadata !2, i32 10} ; [ DW_TAG_subprogram ]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/home/ubuntu/test_cast/point_struct.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8, metadata !9}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, null} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!10 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"main", metadata !"main", metadata !"", i32 21, metadata !11, i1 false, i1 true, i32 0, i32 0, null, i32 0, i1 false, i32 ()* @main, null, null, metadata !2, i32 21} ; [ DW_TAG_subprogram ]
!11 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !12, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!12 = metadata !{metadata !8}
!13 = metadata !{i32 786449, metadata !14, i32 1, metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !15, metadata !2, metadata !2, metadata !""} ; [ DW_TA
!14 = metadata !{metadata !"/home/ubuntu/klee/runtime/Intrinsic/klee_choose.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!15 = metadata !{metadata !16}
!16 = metadata !{i32 786478, metadata !17, metadata !18, metadata !"klee_choose", metadata !"klee_choose", metadata !"", i32 12, metadata !19, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i64 (i64)* @klee_choose, null, null, metadata !23, i32
!17 = metadata !{metadata !"klee_choose.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!18 = metadata !{i32 786473, metadata !17}        ; [ DW_TAG_file_type ] [/home/ubuntu/klee/runtime/Intrinsic/klee_choose.c]
!19 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !20, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!20 = metadata !{metadata !21, metadata !21}
!21 = metadata !{i32 786454, metadata !17, null, metadata !"uintptr_t", i32 122, i64 0, i64 0, i64 0, i32 0, metadata !22} ; [ DW_TAG_typedef ] [uintptr_t] [line 122, size 0, align 0, offset 0] [from long unsigned int]
!22 = metadata !{i32 786468, null, null, metadata !"long unsigned int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [long unsigned int] [line 0, size 64, align 64, offset 0, enc DW_ATE_unsigned]
!23 = metadata !{metadata !24, metadata !25}
!24 = metadata !{i32 786689, metadata !16, metadata !"n", metadata !18, i32 16777228, metadata !21, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [n] [line 12]
!25 = metadata !{i32 786688, metadata !16, metadata !"x", metadata !18, i32 13, metadata !21, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x] [line 13]
!26 = metadata !{i32 786449, metadata !27, i32 1, metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !28, metadata !2, metadata !2, metadata !""} ; [ DW_TA
!27 = metadata !{metadata !"/home/ubuntu/klee/runtime/Intrinsic/klee_div_zero_check.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!28 = metadata !{metadata !29}
!29 = metadata !{i32 786478, metadata !30, metadata !31, metadata !"klee_div_zero_check", metadata !"klee_div_zero_check", metadata !"", i32 12, metadata !32, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (i64)* @klee_div_zero_check, null
!30 = metadata !{metadata !"klee_div_zero_check.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!31 = metadata !{i32 786473, metadata !30}        ; [ DW_TAG_file_type ] [/home/ubuntu/klee/runtime/Intrinsic/klee_div_zero_check.c]
!32 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !33, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!33 = metadata !{null, metadata !34}
!34 = metadata !{i32 786468, null, null, metadata !"long long int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [long long int] [line 0, size 64, align 64, offset 0, enc DW_ATE_signed]
!35 = metadata !{metadata !36}
!36 = metadata !{i32 786689, metadata !29, metadata !"z", metadata !31, i32 16777228, metadata !34, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [z] [line 12]
!37 = metadata !{i32 786449, metadata !38, i32 1, metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !39, metadata !2, metadata !2, metadata !""} ; [ DW_TA
!38 = metadata !{metadata !"/home/ubuntu/klee/runtime/Intrinsic/klee_int.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!39 = metadata !{metadata !40}
!40 = metadata !{i32 786478, metadata !41, metadata !42, metadata !"klee_int", metadata !"klee_int", metadata !"", i32 13, metadata !43, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i8*)* @klee_int, null, null, metadata !48, i32 13} ; [ 
!41 = metadata !{metadata !"klee_int.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!42 = metadata !{i32 786473, metadata !41}        ; [ DW_TAG_file_type ] [/home/ubuntu/klee/runtime/Intrinsic/klee_int.c]
!43 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !44, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!44 = metadata !{metadata !8, metadata !45}
!45 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !46} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!46 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !47} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from char]
!47 = metadata !{i32 786468, null, null, metadata !"char", i32 0, i64 8, i64 8, i64 0, i32 0, i32 6} ; [ DW_TAG_base_type ] [char] [line 0, size 8, align 8, offset 0, enc DW_ATE_signed_char]
!48 = metadata !{metadata !49, metadata !50}
!49 = metadata !{i32 786689, metadata !40, metadata !"name", metadata !42, i32 16777229, metadata !45, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [name] [line 13]
!50 = metadata !{i32 786688, metadata !40, metadata !"x", metadata !42, i32 14, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x] [line 14]
!51 = metadata !{i32 786449, metadata !52, i32 1, metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !53, metadata !2, metadata !2, metadata !""} ; [ DW_TA
!52 = metadata !{metadata !"/home/ubuntu/klee/runtime/Intrinsic/klee_overshift_check.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!53 = metadata !{metadata !54}
!54 = metadata !{i32 786478, metadata !55, metadata !56, metadata !"klee_overshift_check", metadata !"klee_overshift_check", metadata !"", i32 20, metadata !57, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (i64, i64)* @klee_overshift_che
!55 = metadata !{metadata !"klee_overshift_check.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!56 = metadata !{i32 786473, metadata !55}        ; [ DW_TAG_file_type ] [/home/ubuntu/klee/runtime/Intrinsic/klee_overshift_check.c]
!57 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !58, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!58 = metadata !{null, metadata !59, metadata !59}
!59 = metadata !{i32 786468, null, null, metadata !"long long unsigned int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [long long unsigned int] [line 0, size 64, align 64, offset 0, enc DW_ATE_unsigned]
!60 = metadata !{metadata !61, metadata !62}
!61 = metadata !{i32 786689, metadata !54, metadata !"bitWidth", metadata !56, i32 16777236, metadata !59, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [bitWidth] [line 20]
!62 = metadata !{i32 786689, metadata !54, metadata !"shift", metadata !56, i32 33554452, metadata !59, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [shift] [line 20]
!63 = metadata !{i32 786449, metadata !64, i32 1, metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !65, metadata !2, metadata !2, metadata !""} ; [ DW_TA
!64 = metadata !{metadata !"/home/ubuntu/klee/runtime/Intrinsic/klee_range.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!65 = metadata !{metadata !66}
!66 = metadata !{i32 786478, metadata !67, metadata !68, metadata !"klee_range", metadata !"klee_range", metadata !"", i32 13, metadata !69, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i32, i32, i8*)* @klee_range, null, null, metadata !
!67 = metadata !{metadata !"klee_range.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!68 = metadata !{i32 786473, metadata !67}        ; [ DW_TAG_file_type ] [/home/ubuntu/klee/runtime/Intrinsic/klee_range.c]
!69 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !70, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!70 = metadata !{metadata !8, metadata !8, metadata !8, metadata !45}
!71 = metadata !{metadata !72, metadata !73, metadata !74, metadata !75}
!72 = metadata !{i32 786689, metadata !66, metadata !"start", metadata !68, i32 16777229, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [start] [line 13]
!73 = metadata !{i32 786689, metadata !66, metadata !"end", metadata !68, i32 33554445, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [end] [line 13]
!74 = metadata !{i32 786689, metadata !66, metadata !"name", metadata !68, i32 50331661, metadata !45, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [name] [line 13]
!75 = metadata !{i32 786688, metadata !66, metadata !"x", metadata !68, i32 14, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x] [line 14]
!76 = metadata !{i32 786449, metadata !77, i32 1, metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !78, metadata !2, metadata !2, metadata !""} ; [ DW_TA
!77 = metadata !{metadata !"/home/ubuntu/klee/runtime/Intrinsic/memcpy.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!78 = metadata !{metadata !79}
!79 = metadata !{i32 786478, metadata !80, metadata !81, metadata !"memcpy", metadata !"memcpy", metadata !"", i32 12, metadata !82, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i8*, i64)* @memcpy, null, null, metadata !87, i32 12} 
!80 = metadata !{metadata !"memcpy.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!81 = metadata !{i32 786473, metadata !80}        ; [ DW_TAG_file_type ] [/home/ubuntu/klee/runtime/Intrinsic/memcpy.c]
!82 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !83, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!83 = metadata !{metadata !9, metadata !9, metadata !84, metadata !86}
!84 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !85} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!85 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from ]
!86 = metadata !{i32 786454, metadata !80, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !22} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!87 = metadata !{metadata !88, metadata !89, metadata !90, metadata !91, metadata !93}
!88 = metadata !{i32 786689, metadata !79, metadata !"destaddr", metadata !81, i32 16777228, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [destaddr] [line 12]
!89 = metadata !{i32 786689, metadata !79, metadata !"srcaddr", metadata !81, i32 33554444, metadata !84, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [srcaddr] [line 12]
!90 = metadata !{i32 786689, metadata !79, metadata !"len", metadata !81, i32 50331660, metadata !86, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [len] [line 12]
!91 = metadata !{i32 786688, metadata !79, metadata !"dest", metadata !81, i32 13, metadata !92, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dest] [line 13]
!92 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !47} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from char]
!93 = metadata !{i32 786688, metadata !79, metadata !"src", metadata !81, i32 14, metadata !45, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [src] [line 14]
!94 = metadata !{i32 786449, metadata !95, i32 1, metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !96, metadata !2, metadata !2, metadata !""} ; [ DW_TA
!95 = metadata !{metadata !"/home/ubuntu/klee/runtime/Intrinsic/memmove.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!96 = metadata !{metadata !97}
!97 = metadata !{i32 786478, metadata !98, metadata !99, metadata !"memmove", metadata !"memmove", metadata !"", i32 12, metadata !100, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i8*, i64)* @memmove, null, null, metadata !103, i32
!98 = metadata !{metadata !"memmove.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!99 = metadata !{i32 786473, metadata !98}        ; [ DW_TAG_file_type ] [/home/ubuntu/klee/runtime/Intrinsic/memmove.c]
!100 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !101, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!101 = metadata !{metadata !9, metadata !9, metadata !84, metadata !102}
!102 = metadata !{i32 786454, metadata !98, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !22} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!103 = metadata !{metadata !104, metadata !105, metadata !106, metadata !107, metadata !108}
!104 = metadata !{i32 786689, metadata !97, metadata !"dst", metadata !99, i32 16777228, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [dst] [line 12]
!105 = metadata !{i32 786689, metadata !97, metadata !"src", metadata !99, i32 33554444, metadata !84, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [src] [line 12]
!106 = metadata !{i32 786689, metadata !97, metadata !"count", metadata !99, i32 50331660, metadata !102, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [count] [line 12]
!107 = metadata !{i32 786688, metadata !97, metadata !"a", metadata !99, i32 13, metadata !92, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [a] [line 13]
!108 = metadata !{i32 786688, metadata !97, metadata !"b", metadata !99, i32 14, metadata !45, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [b] [line 14]
!109 = metadata !{i32 786449, metadata !110, i32 1, metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !111, metadata !2, metadata !2, metadata !""} ; [ DW
!110 = metadata !{metadata !"/home/ubuntu/klee/runtime/Intrinsic/mempcpy.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!111 = metadata !{metadata !112}
!112 = metadata !{i32 786478, metadata !113, metadata !114, metadata !"mempcpy", metadata !"mempcpy", metadata !"", i32 11, metadata !115, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i8*, i64)* @mempcpy, null, null, metadata !118, 
!113 = metadata !{metadata !"mempcpy.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!114 = metadata !{i32 786473, metadata !113}      ; [ DW_TAG_file_type ] [/home/ubuntu/klee/runtime/Intrinsic/mempcpy.c]
!115 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !116, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!116 = metadata !{metadata !9, metadata !9, metadata !84, metadata !117}
!117 = metadata !{i32 786454, metadata !113, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !22} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!118 = metadata !{metadata !119, metadata !120, metadata !121, metadata !122, metadata !123}
!119 = metadata !{i32 786689, metadata !112, metadata !"destaddr", metadata !114, i32 16777227, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [destaddr] [line 11]
!120 = metadata !{i32 786689, metadata !112, metadata !"srcaddr", metadata !114, i32 33554443, metadata !84, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [srcaddr] [line 11]
!121 = metadata !{i32 786689, metadata !112, metadata !"len", metadata !114, i32 50331659, metadata !117, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [len] [line 11]
!122 = metadata !{i32 786688, metadata !112, metadata !"dest", metadata !114, i32 12, metadata !92, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dest] [line 12]
!123 = metadata !{i32 786688, metadata !112, metadata !"src", metadata !114, i32 13, metadata !45, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [src] [line 13]
!124 = metadata !{i32 786449, metadata !125, i32 1, metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !126, metadata !2, metadata !2, metadata !""} ; [ DW
!125 = metadata !{metadata !"/home/ubuntu/klee/runtime/Intrinsic/memset.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!126 = metadata !{metadata !127}
!127 = metadata !{i32 786478, metadata !128, metadata !129, metadata !"memset", metadata !"memset", metadata !"", i32 11, metadata !130, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i32, i64)* @memset, null, null, metadata !133, i32
!128 = metadata !{metadata !"memset.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!129 = metadata !{i32 786473, metadata !128}      ; [ DW_TAG_file_type ] [/home/ubuntu/klee/runtime/Intrinsic/memset.c]
!130 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !131, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!131 = metadata !{metadata !9, metadata !9, metadata !8, metadata !132}
!132 = metadata !{i32 786454, metadata !128, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !22} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!133 = metadata !{metadata !134, metadata !135, metadata !136, metadata !137}
!134 = metadata !{i32 786689, metadata !127, metadata !"dst", metadata !129, i32 16777227, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [dst] [line 11]
!135 = metadata !{i32 786689, metadata !127, metadata !"s", metadata !129, i32 33554443, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [s] [line 11]
!136 = metadata !{i32 786689, metadata !127, metadata !"count", metadata !129, i32 50331659, metadata !132, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [count] [line 11]
!137 = metadata !{i32 786688, metadata !127, metadata !"a", metadata !129, i32 12, metadata !138, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [a] [line 12]
!138 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !139} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!139 = metadata !{i32 786485, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !47} ; [ DW_TAG_volatile_type ] [line 0, size 0, align 0, offset 0] [from char]
!140 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!141 = metadata !{i32 1, metadata !"Debug Info Version", i32 1}
!142 = metadata !{metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)"}
!143 = metadata !{i32 11, i32 0, metadata !4, null}
!144 = metadata !{i32 12, i32 0, metadata !145, null}
!145 = metadata !{i32 786443, metadata !1, metadata !4, i32 12, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/ubuntu/test_cast/point_struct.c]
!146 = metadata !{i32 13, i32 0, metadata !147, null}
!147 = metadata !{i32 786443, metadata !1, metadata !145, i32 12, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/ubuntu/test_cast/point_struct.c]
!148 = metadata !{i32 16, i32 0, metadata !149, null}
!149 = metadata !{i32 786443, metadata !1, metadata !145, i32 15, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/home/ubuntu/test_cast/point_struct.c]
!150 = metadata !{i32 18, i32 0, metadata !4, null}
!151 = metadata !{i32 22, i32 0, metadata !10, null}
!152 = metadata !{i32 23, i32 0, metadata !10, null}
!153 = metadata !{i32 24, i32 0, metadata !10, null}
!154 = metadata !{i32 25, i32 0, metadata !10, null}
!155 = metadata !{i32 14, i32 0, metadata !16, null}
!156 = metadata !{i32 17, i32 0, metadata !157, null}
!157 = metadata !{i32 786443, metadata !17, metadata !16, i32 17, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/klee_choose.c]
!158 = metadata !{metadata !159, metadata !159, i64 0}
!159 = metadata !{metadata !"long", metadata !160, i64 0}
!160 = metadata !{metadata !"omnipotent char", metadata !161, i64 0}
!161 = metadata !{metadata !"Simple C/C++ TBAA"}
!162 = metadata !{i32 18, i32 0, metadata !157, null}
!163 = metadata !{i32 19, i32 0, metadata !16, null}
!164 = metadata !{i32 13, i32 0, metadata !165, null}
!165 = metadata !{i32 786443, metadata !30, metadata !29, i32 13, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/klee_div_zero_check.c]
!166 = metadata !{i32 14, i32 0, metadata !165, null}
!167 = metadata !{i32 15, i32 0, metadata !29, null}
!168 = metadata !{i32 15, i32 0, metadata !40, null}
!169 = metadata !{i32 16, i32 0, metadata !40, null}
!170 = metadata !{metadata !171, metadata !171, i64 0}
!171 = metadata !{metadata !"int", metadata !160, i64 0}
!172 = metadata !{i32 21, i32 0, metadata !173, null}
!173 = metadata !{i32 786443, metadata !55, metadata !54, i32 21, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/klee_overshift_check.c]
!174 = metadata !{i32 27, i32 0, metadata !175, null}
!175 = metadata !{i32 786443, metadata !55, metadata !173, i32 21, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/klee_overshift_check.c]
!176 = metadata !{i32 29, i32 0, metadata !54, null}
!177 = metadata !{i32 16, i32 0, metadata !178, null}
!178 = metadata !{i32 786443, metadata !67, metadata !66, i32 16, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/klee_range.c]
!179 = metadata !{i32 17, i32 0, metadata !178, null}
!180 = metadata !{i32 19, i32 0, metadata !181, null}
!181 = metadata !{i32 786443, metadata !67, metadata !66, i32 19, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/klee_range.c]
!182 = metadata !{i32 22, i32 0, metadata !183, null}
!183 = metadata !{i32 786443, metadata !67, metadata !181, i32 21, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/klee_range.c]
!184 = metadata !{i32 25, i32 0, metadata !185, null}
!185 = metadata !{i32 786443, metadata !67, metadata !183, i32 25, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/klee_range.c]
!186 = metadata !{i32 26, i32 0, metadata !187, null}
!187 = metadata !{i32 786443, metadata !67, metadata !185, i32 25, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/klee_range.c]
!188 = metadata !{i32 27, i32 0, metadata !187, null}
!189 = metadata !{i32 28, i32 0, metadata !190, null}
!190 = metadata !{i32 786443, metadata !67, metadata !185, i32 27, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/klee_range.c]
!191 = metadata !{i32 29, i32 0, metadata !190, null}
!192 = metadata !{i32 32, i32 0, metadata !183, null}
!193 = metadata !{i32 34, i32 0, metadata !66, null}
!194 = metadata !{i32 16, i32 0, metadata !79, null}
!195 = metadata !{i32 17, i32 0, metadata !79, null}
!196 = metadata !{metadata !196, metadata !197, metadata !198}
!197 = metadata !{metadata !"llvm.vectorizer.width", i32 1}
!198 = metadata !{metadata !"llvm.vectorizer.unroll", i32 1}
!199 = metadata !{metadata !160, metadata !160, i64 0}
!200 = metadata !{metadata !200, metadata !197, metadata !198}
!201 = metadata !{i32 18, i32 0, metadata !79, null}
!202 = metadata !{i32 16, i32 0, metadata !203, null}
!203 = metadata !{i32 786443, metadata !98, metadata !97, i32 16, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/memmove.c]
!204 = metadata !{i32 19, i32 0, metadata !205, null}
!205 = metadata !{i32 786443, metadata !98, metadata !97, i32 19, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/memmove.c]
!206 = metadata !{i32 20, i32 0, metadata !207, null}
!207 = metadata !{i32 786443, metadata !98, metadata !205, i32 19, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/memmove.c]
!208 = metadata !{metadata !208, metadata !197, metadata !198}
!209 = metadata !{metadata !209, metadata !197, metadata !198}
!210 = metadata !{i32 22, i32 0, metadata !211, null}
!211 = metadata !{i32 786443, metadata !98, metadata !205, i32 21, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/memmove.c]
!212 = metadata !{i32 24, i32 0, metadata !211, null}
!213 = metadata !{i32 23, i32 0, metadata !211, null}
!214 = metadata !{metadata !214, metadata !197, metadata !198}
!215 = metadata !{metadata !215, metadata !197, metadata !198}
!216 = metadata !{i32 28, i32 0, metadata !97, null}
!217 = metadata !{i32 15, i32 0, metadata !112, null}
!218 = metadata !{i32 16, i32 0, metadata !112, null}
!219 = metadata !{metadata !219, metadata !197, metadata !198}
!220 = metadata !{metadata !220, metadata !197, metadata !198}
!221 = metadata !{i32 17, i32 0, metadata !112, null}
!222 = metadata !{i32 13, i32 0, metadata !127, null}
!223 = metadata !{i32 14, i32 0, metadata !127, null}
!224 = metadata !{i32 15, i32 0, metadata !127, null}

; ModuleID = 'main.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [2 x i8] c"a\00", align 1
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
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %a = alloca i32, align 4
  store i32 0, i32* %1
  %2 = bitcast i32* %a to i8*, !dbg !140
  call void @klee_make_symbolic(i8* %2, i64 4, i8* getelementptr inbounds ([2 x i8]* @.str, i32 0, i32 0)), !dbg !140
  %3 = load i32* %a, align 4, !dbg !141
  %4 = call i32 @foo(i32 %3), !dbg !141
  ret i32 %4, !dbg !141
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata) #1

declare void @klee_make_symbolic(i8*, i64, i8*) #2

declare i32 @foo(i32) #2

; Function Attrs: nounwind ssp uwtable
define i64 @klee_choose(i64 %n) #3 {
  %x = alloca i64, align 8
  %1 = bitcast i64* %x to i8*, !dbg !142
  call void @klee_make_symbolic(i8* %1, i64 8, i8* getelementptr inbounds ([12 x i8]* @.str1, i64 0, i64 0)) #6, !dbg !142
  %2 = load i64* %x, align 8, !dbg !143, !tbaa !145
  %3 = icmp ult i64 %2, %n, !dbg !143
  br i1 %3, label %5, label %4, !dbg !143

; <label>:4                                       ; preds = %0
  call void @klee_silent_exit(i32 0) #7, !dbg !149
  unreachable, !dbg !149

; <label>:5                                       ; preds = %0
  ret i64 %2, !dbg !150
}

; Function Attrs: noreturn
declare void @klee_silent_exit(i32) #4

; Function Attrs: nounwind readnone
declare void @llvm.dbg.value(metadata, i64, metadata) #1

; Function Attrs: nounwind ssp uwtable
define void @klee_div_zero_check(i64 %z) #3 {
  %1 = icmp eq i64 %z, 0, !dbg !151
  br i1 %1, label %2, label %3, !dbg !151

; <label>:2                                       ; preds = %0
  tail call void @klee_report_error(i8* getelementptr inbounds ([22 x i8]* @.str12, i64 0, i64 0), i32 14, i8* getelementptr inbounds ([15 x i8]* @.str123, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str2, i64 0, i64 0)) #7, !dbg !153
  unreachable, !dbg !153

; <label>:3                                       ; preds = %0
  ret void, !dbg !154
}

; Function Attrs: noreturn
declare void @klee_report_error(i8*, i32, i8*, i8*) #4

; Function Attrs: nounwind ssp uwtable
define i32 @klee_int(i8* %name) #3 {
  %x = alloca i32, align 4
  %1 = bitcast i32* %x to i8*, !dbg !155
  call void @klee_make_symbolic(i8* %1, i64 4, i8* %name) #6, !dbg !155
  %2 = load i32* %x, align 4, !dbg !156, !tbaa !157
  ret i32 %2, !dbg !156
}

; Function Attrs: nounwind ssp uwtable
define void @klee_overshift_check(i64 %bitWidth, i64 %shift) #3 {
  %1 = icmp ult i64 %shift, %bitWidth, !dbg !159
  br i1 %1, label %3, label %2, !dbg !159

; <label>:2                                       ; preds = %0
  tail call void @klee_report_error(i8* getelementptr inbounds ([8 x i8]* @.str3, i64 0, i64 0), i32 0, i8* getelementptr inbounds ([16 x i8]* @.str14, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8]* @.str25, i64 0, i64 0)) #7, !dbg !161
  unreachable, !dbg !161

; <label>:3                                       ; preds = %0
  ret void, !dbg !163
}

; Function Attrs: nounwind ssp uwtable
define i32 @klee_range(i32 %start, i32 %end, i8* %name) #3 {
  %x = alloca i32, align 4
  %1 = icmp slt i32 %start, %end, !dbg !164
  br i1 %1, label %3, label %2, !dbg !164

; <label>:2                                       ; preds = %0
  call void @klee_report_error(i8* getelementptr inbounds ([13 x i8]* @.str6, i64 0, i64 0), i32 17, i8* getelementptr inbounds ([14 x i8]* @.str17, i64 0, i64 0), i8* getelementptr inbounds ([5 x i8]* @.str28, i64 0, i64 0)) #7, !dbg !166
  unreachable, !dbg !166

; <label>:3                                       ; preds = %0
  %4 = add nsw i32 %start, 1, !dbg !167
  %5 = icmp eq i32 %4, %end, !dbg !167
  br i1 %5, label %21, label %6, !dbg !167

; <label>:6                                       ; preds = %3
  %7 = bitcast i32* %x to i8*, !dbg !169
  call void @klee_make_symbolic(i8* %7, i64 4, i8* %name) #6, !dbg !169
  %8 = icmp eq i32 %start, 0, !dbg !171
  %9 = load i32* %x, align 4, !dbg !173, !tbaa !157
  br i1 %8, label %10, label %13, !dbg !171

; <label>:10                                      ; preds = %6
  %11 = icmp ult i32 %9, %end, !dbg !173
  %12 = zext i1 %11 to i64, !dbg !173
  call void @klee_assume(i64 %12) #6, !dbg !173
  br label %19, !dbg !175

; <label>:13                                      ; preds = %6
  %14 = icmp sge i32 %9, %start, !dbg !176
  %15 = zext i1 %14 to i64, !dbg !176
  call void @klee_assume(i64 %15) #6, !dbg !176
  %16 = load i32* %x, align 4, !dbg !178, !tbaa !157
  %17 = icmp slt i32 %16, %end, !dbg !178
  %18 = zext i1 %17 to i64, !dbg !178
  call void @klee_assume(i64 %18) #6, !dbg !178
  br label %19

; <label>:19                                      ; preds = %13, %10
  %20 = load i32* %x, align 4, !dbg !179, !tbaa !157
  br label %21, !dbg !179

; <label>:21                                      ; preds = %19, %3
  %.0 = phi i32 [ %20, %19 ], [ %start, %3 ]
  ret i32 %.0, !dbg !180
}

declare void @klee_assume(i64) #5

; Function Attrs: nounwind ssp uwtable
define weak i8* @memcpy(i8* %destaddr, i8* %srcaddr, i64 %len) #3 {
  %1 = icmp eq i64 %len, 0, !dbg !181
  br i1 %1, label %._crit_edge, label %.lr.ph.preheader, !dbg !181

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
  %3 = bitcast i8* %next.gep to <16 x i8>*, !dbg !182
  %wide.load = load <16 x i8>* %3, align 1, !dbg !182
  %next.gep.sum279 = or i64 %index, 16, !dbg !182
  %4 = getelementptr i8* %srcaddr, i64 %next.gep.sum279, !dbg !182
  %5 = bitcast i8* %4 to <16 x i8>*, !dbg !182
  %wide.load200 = load <16 x i8>* %5, align 1, !dbg !182
  %6 = bitcast i8* %next.gep103 to <16 x i8>*, !dbg !182
  store <16 x i8> %wide.load, <16 x i8>* %6, align 1, !dbg !182
  %7 = getelementptr i8* %destaddr, i64 %next.gep.sum279, !dbg !182
  %8 = bitcast i8* %7 to <16 x i8>*, !dbg !182
  store <16 x i8> %wide.load200, <16 x i8>* %8, align 1, !dbg !182
  %index.next = add i64 %index, 32
  %9 = icmp eq i64 %index.next, %n.vec
  br i1 %9, label %middle.block, label %vector.body, !llvm.loop !183

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
  %10 = add i64 %.01, -1, !dbg !181
  %11 = getelementptr inbounds i8* %src.03, i64 1, !dbg !182
  %12 = load i8* %src.03, align 1, !dbg !182, !tbaa !186
  %13 = getelementptr inbounds i8* %dest.02, i64 1, !dbg !182
  store i8 %12, i8* %dest.02, align 1, !dbg !182, !tbaa !186
  %14 = icmp eq i64 %10, 0, !dbg !181
  br i1 %14, label %._crit_edge, label %.lr.ph, !dbg !181, !llvm.loop !187

._crit_edge:                                      ; preds = %.lr.ph, %middle.block, %0
  ret i8* %destaddr, !dbg !188
}

; Function Attrs: nounwind ssp uwtable
define weak i8* @memmove(i8* %dst, i8* %src, i64 %count) #3 {
  %1 = icmp eq i8* %src, %dst, !dbg !189
  br i1 %1, label %.loopexit, label %2, !dbg !189

; <label>:2                                       ; preds = %0
  %3 = icmp ugt i8* %src, %dst, !dbg !191
  br i1 %3, label %.preheader, label %18, !dbg !191

.preheader:                                       ; preds = %2
  %4 = icmp eq i64 %count, 0, !dbg !193
  br i1 %4, label %.loopexit, label %.lr.ph.preheader, !dbg !193

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
  %6 = bitcast i8* %next.gep to <16 x i8>*, !dbg !193
  %wide.load = load <16 x i8>* %6, align 1, !dbg !193
  %next.gep.sum586 = or i64 %index, 16, !dbg !193
  %7 = getelementptr i8* %src, i64 %next.gep.sum586, !dbg !193
  %8 = bitcast i8* %7 to <16 x i8>*, !dbg !193
  %wide.load207 = load <16 x i8>* %8, align 1, !dbg !193
  %9 = bitcast i8* %next.gep110 to <16 x i8>*, !dbg !193
  store <16 x i8> %wide.load, <16 x i8>* %9, align 1, !dbg !193
  %10 = getelementptr i8* %dst, i64 %next.gep.sum586, !dbg !193
  %11 = bitcast i8* %10 to <16 x i8>*, !dbg !193
  store <16 x i8> %wide.load207, <16 x i8>* %11, align 1, !dbg !193
  %index.next = add i64 %index, 32
  %12 = icmp eq i64 %index.next, %n.vec
  br i1 %12, label %middle.block, label %vector.body, !llvm.loop !195

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
  %13 = add i64 %.02, -1, !dbg !193
  %14 = getelementptr inbounds i8* %b.04, i64 1, !dbg !193
  %15 = load i8* %b.04, align 1, !dbg !193, !tbaa !186
  %16 = getelementptr inbounds i8* %a.03, i64 1, !dbg !193
  store i8 %15, i8* %a.03, align 1, !dbg !193, !tbaa !186
  %17 = icmp eq i64 %13, 0, !dbg !193
  br i1 %17, label %.loopexit, label %.lr.ph, !dbg !193, !llvm.loop !196

; <label>:18                                      ; preds = %2
  %19 = add i64 %count, -1, !dbg !197
  %20 = icmp eq i64 %count, 0, !dbg !199
  br i1 %20, label %.loopexit, label %.lr.ph9, !dbg !199

.lr.ph9:                                          ; preds = %18
  %21 = getelementptr inbounds i8* %src, i64 %19, !dbg !200
  %22 = getelementptr inbounds i8* %dst, i64 %19, !dbg !197
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
  %next.gep236.sum = add i64 %.sum440, -15, !dbg !199
  %23 = getelementptr i8* %src, i64 %next.gep236.sum, !dbg !199
  %24 = bitcast i8* %23 to <16 x i8>*, !dbg !199
  %wide.load434 = load <16 x i8>* %24, align 1, !dbg !199
  %reverse = shufflevector <16 x i8> %wide.load434, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>, !dbg !199
  %.sum505 = add i64 %.sum440, -31, !dbg !199
  %25 = getelementptr i8* %src, i64 %.sum505, !dbg !199
  %26 = bitcast i8* %25 to <16 x i8>*, !dbg !199
  %wide.load435 = load <16 x i8>* %26, align 1, !dbg !199
  %reverse436 = shufflevector <16 x i8> %wide.load435, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>, !dbg !199
  %reverse437 = shufflevector <16 x i8> %reverse, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>, !dbg !199
  %27 = getelementptr i8* %dst, i64 %next.gep236.sum, !dbg !199
  %28 = bitcast i8* %27 to <16 x i8>*, !dbg !199
  store <16 x i8> %reverse437, <16 x i8>* %28, align 1, !dbg !199
  %reverse438 = shufflevector <16 x i8> %reverse436, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>, !dbg !199
  %29 = getelementptr i8* %dst, i64 %.sum505, !dbg !199
  %30 = bitcast i8* %29 to <16 x i8>*, !dbg !199
  store <16 x i8> %reverse438, <16 x i8>* %30, align 1, !dbg !199
  %index.next234 = add i64 %index212, 32
  %31 = icmp eq i64 %index.next234, %n.vec215
  br i1 %31, label %middle.block210, label %vector.body209, !llvm.loop !201

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
  %32 = add i64 %.16, -1, !dbg !199
  %33 = getelementptr inbounds i8* %b.18, i64 -1, !dbg !199
  %34 = load i8* %b.18, align 1, !dbg !199, !tbaa !186
  %35 = getelementptr inbounds i8* %a.17, i64 -1, !dbg !199
  store i8 %34, i8* %a.17, align 1, !dbg !199, !tbaa !186
  %36 = icmp eq i64 %32, 0, !dbg !199
  br i1 %36, label %.loopexit, label %scalar.ph211, !dbg !199, !llvm.loop !202

.loopexit:                                        ; preds = %scalar.ph211, %middle.block210, %18, %.lr.ph, %middle.block, %.preheader, %0
  ret i8* %dst, !dbg !203
}

; Function Attrs: nounwind ssp uwtable
define weak i8* @mempcpy(i8* %destaddr, i8* %srcaddr, i64 %len) #3 {
  %1 = icmp eq i64 %len, 0, !dbg !204
  br i1 %1, label %15, label %.lr.ph.preheader, !dbg !204

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
  %3 = bitcast i8* %next.gep to <16 x i8>*, !dbg !205
  %wide.load = load <16 x i8>* %3, align 1, !dbg !205
  %next.gep.sum280 = or i64 %index, 16, !dbg !205
  %4 = getelementptr i8* %srcaddr, i64 %next.gep.sum280, !dbg !205
  %5 = bitcast i8* %4 to <16 x i8>*, !dbg !205
  %wide.load201 = load <16 x i8>* %5, align 1, !dbg !205
  %6 = bitcast i8* %next.gep104 to <16 x i8>*, !dbg !205
  store <16 x i8> %wide.load, <16 x i8>* %6, align 1, !dbg !205
  %7 = getelementptr i8* %destaddr, i64 %next.gep.sum280, !dbg !205
  %8 = bitcast i8* %7 to <16 x i8>*, !dbg !205
  store <16 x i8> %wide.load201, <16 x i8>* %8, align 1, !dbg !205
  %index.next = add i64 %index, 32
  %9 = icmp eq i64 %index.next, %n.vec
  br i1 %9, label %middle.block, label %vector.body, !llvm.loop !206

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
  %10 = add i64 %.01, -1, !dbg !204
  %11 = getelementptr inbounds i8* %src.03, i64 1, !dbg !205
  %12 = load i8* %src.03, align 1, !dbg !205, !tbaa !186
  %13 = getelementptr inbounds i8* %dest.02, i64 1, !dbg !205
  store i8 %12, i8* %dest.02, align 1, !dbg !205, !tbaa !186
  %14 = icmp eq i64 %10, 0, !dbg !204
  br i1 %14, label %._crit_edge, label %.lr.ph, !dbg !204, !llvm.loop !207

._crit_edge:                                      ; preds = %.lr.ph, %middle.block
  %scevgep = getelementptr i8* %destaddr, i64 %len
  br label %15, !dbg !204

; <label>:15                                      ; preds = %._crit_edge, %0
  %dest.0.lcssa = phi i8* [ %scevgep, %._crit_edge ], [ %destaddr, %0 ]
  ret i8* %dest.0.lcssa, !dbg !208
}

; Function Attrs: nounwind ssp uwtable
define weak i8* @memset(i8* %dst, i32 %s, i64 %count) #3 {
  %1 = icmp eq i64 %count, 0, !dbg !209
  br i1 %1, label %._crit_edge, label %.lr.ph, !dbg !209

.lr.ph:                                           ; preds = %0
  %2 = trunc i32 %s to i8, !dbg !210
  br label %3, !dbg !209

; <label>:3                                       ; preds = %3, %.lr.ph
  %a.02 = phi i8* [ %dst, %.lr.ph ], [ %5, %3 ]
  %.01 = phi i64 [ %count, %.lr.ph ], [ %4, %3 ]
  %4 = add i64 %.01, -1, !dbg !209
  %5 = getelementptr inbounds i8* %a.02, i64 1, !dbg !210
  store volatile i8 %2, i8* %a.02, align 1, !dbg !210, !tbaa !186
  %6 = icmp eq i64 %4, 0, !dbg !209
  br i1 %6, label %._crit_edge, label %3, !dbg !209

._crit_edge:                                      ; preds = %3, %0
  ret i8* %dst, !dbg !211
}

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float
attributes #1 = { nounwind readnone }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind ssp uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="4" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noreturn "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="4" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="4" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { nobuiltin nounwind }
attributes #7 = { nobuiltin noreturn nounwind }

!llvm.dbg.cu = !{!0, !9, !22, !33, !47, !59, !72, !91, !106, !121}
!llvm.module.flags = !{!137, !138}
!llvm.ident = !{!139, !139, !139, !139, !139, !139, !139, !139, !139, !139}

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !""} ; [ DW_TAG
!1 = metadata !{metadata !"main.c", metadata !"/home/ubuntu/test_so"}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"main", metadata !"main", metadata !"", i32 4, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 ()* @main, null, null, metadata !2, i32 5} ; [ DW_TAG_subprogram ] [
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/home/ubuntu/test_so/main.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 786449, metadata !10, i32 1, metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !11, metadata !2, metadata !2, metadata !""} ; [ DW_TAG
!10 = metadata !{metadata !"/home/ubuntu/klee/runtime/Intrinsic/klee_choose.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!11 = metadata !{metadata !12}
!12 = metadata !{i32 786478, metadata !13, metadata !14, metadata !"klee_choose", metadata !"klee_choose", metadata !"", i32 12, metadata !15, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i64 (i64)* @klee_choose, null, null, metadata !19, i32
!13 = metadata !{metadata !"klee_choose.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!14 = metadata !{i32 786473, metadata !13}        ; [ DW_TAG_file_type ] [/home/ubuntu/klee/runtime/Intrinsic/klee_choose.c]
!15 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !16, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!16 = metadata !{metadata !17, metadata !17}
!17 = metadata !{i32 786454, metadata !13, null, metadata !"uintptr_t", i32 122, i64 0, i64 0, i64 0, i32 0, metadata !18} ; [ DW_TAG_typedef ] [uintptr_t] [line 122, size 0, align 0, offset 0] [from long unsigned int]
!18 = metadata !{i32 786468, null, null, metadata !"long unsigned int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [long unsigned int] [line 0, size 64, align 64, offset 0, enc DW_ATE_unsigned]
!19 = metadata !{metadata !20, metadata !21}
!20 = metadata !{i32 786689, metadata !12, metadata !"n", metadata !14, i32 16777228, metadata !17, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [n] [line 12]
!21 = metadata !{i32 786688, metadata !12, metadata !"x", metadata !14, i32 13, metadata !17, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x] [line 13]
!22 = metadata !{i32 786449, metadata !23, i32 1, metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !24, metadata !2, metadata !2, metadata !""} ; [ DW_TA
!23 = metadata !{metadata !"/home/ubuntu/klee/runtime/Intrinsic/klee_div_zero_check.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!24 = metadata !{metadata !25}
!25 = metadata !{i32 786478, metadata !26, metadata !27, metadata !"klee_div_zero_check", metadata !"klee_div_zero_check", metadata !"", i32 12, metadata !28, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (i64)* @klee_div_zero_check, null
!26 = metadata !{metadata !"klee_div_zero_check.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!27 = metadata !{i32 786473, metadata !26}        ; [ DW_TAG_file_type ] [/home/ubuntu/klee/runtime/Intrinsic/klee_div_zero_check.c]
!28 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !29, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!29 = metadata !{null, metadata !30}
!30 = metadata !{i32 786468, null, null, metadata !"long long int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [long long int] [line 0, size 64, align 64, offset 0, enc DW_ATE_signed]
!31 = metadata !{metadata !32}
!32 = metadata !{i32 786689, metadata !25, metadata !"z", metadata !27, i32 16777228, metadata !30, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [z] [line 12]
!33 = metadata !{i32 786449, metadata !34, i32 1, metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !35, metadata !2, metadata !2, metadata !""} ; [ DW_TA
!34 = metadata !{metadata !"/home/ubuntu/klee/runtime/Intrinsic/klee_int.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!35 = metadata !{metadata !36}
!36 = metadata !{i32 786478, metadata !37, metadata !38, metadata !"klee_int", metadata !"klee_int", metadata !"", i32 13, metadata !39, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i8*)* @klee_int, null, null, metadata !44, i32 13} ; [ 
!37 = metadata !{metadata !"klee_int.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!38 = metadata !{i32 786473, metadata !37}        ; [ DW_TAG_file_type ] [/home/ubuntu/klee/runtime/Intrinsic/klee_int.c]
!39 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !40, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!40 = metadata !{metadata !8, metadata !41}
!41 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !42} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!42 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !43} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from char]
!43 = metadata !{i32 786468, null, null, metadata !"char", i32 0, i64 8, i64 8, i64 0, i32 0, i32 6} ; [ DW_TAG_base_type ] [char] [line 0, size 8, align 8, offset 0, enc DW_ATE_signed_char]
!44 = metadata !{metadata !45, metadata !46}
!45 = metadata !{i32 786689, metadata !36, metadata !"name", metadata !38, i32 16777229, metadata !41, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [name] [line 13]
!46 = metadata !{i32 786688, metadata !36, metadata !"x", metadata !38, i32 14, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x] [line 14]
!47 = metadata !{i32 786449, metadata !48, i32 1, metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !49, metadata !2, metadata !2, metadata !""} ; [ DW_TA
!48 = metadata !{metadata !"/home/ubuntu/klee/runtime/Intrinsic/klee_overshift_check.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!49 = metadata !{metadata !50}
!50 = metadata !{i32 786478, metadata !51, metadata !52, metadata !"klee_overshift_check", metadata !"klee_overshift_check", metadata !"", i32 20, metadata !53, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (i64, i64)* @klee_overshift_che
!51 = metadata !{metadata !"klee_overshift_check.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!52 = metadata !{i32 786473, metadata !51}        ; [ DW_TAG_file_type ] [/home/ubuntu/klee/runtime/Intrinsic/klee_overshift_check.c]
!53 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !54, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!54 = metadata !{null, metadata !55, metadata !55}
!55 = metadata !{i32 786468, null, null, metadata !"long long unsigned int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [long long unsigned int] [line 0, size 64, align 64, offset 0, enc DW_ATE_unsigned]
!56 = metadata !{metadata !57, metadata !58}
!57 = metadata !{i32 786689, metadata !50, metadata !"bitWidth", metadata !52, i32 16777236, metadata !55, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [bitWidth] [line 20]
!58 = metadata !{i32 786689, metadata !50, metadata !"shift", metadata !52, i32 33554452, metadata !55, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [shift] [line 20]
!59 = metadata !{i32 786449, metadata !60, i32 1, metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !61, metadata !2, metadata !2, metadata !""} ; [ DW_TA
!60 = metadata !{metadata !"/home/ubuntu/klee/runtime/Intrinsic/klee_range.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!61 = metadata !{metadata !62}
!62 = metadata !{i32 786478, metadata !63, metadata !64, metadata !"klee_range", metadata !"klee_range", metadata !"", i32 13, metadata !65, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i32, i32, i8*)* @klee_range, null, null, metadata !
!63 = metadata !{metadata !"klee_range.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!64 = metadata !{i32 786473, metadata !63}        ; [ DW_TAG_file_type ] [/home/ubuntu/klee/runtime/Intrinsic/klee_range.c]
!65 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !66, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!66 = metadata !{metadata !8, metadata !8, metadata !8, metadata !41}
!67 = metadata !{metadata !68, metadata !69, metadata !70, metadata !71}
!68 = metadata !{i32 786689, metadata !62, metadata !"start", metadata !64, i32 16777229, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [start] [line 13]
!69 = metadata !{i32 786689, metadata !62, metadata !"end", metadata !64, i32 33554445, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [end] [line 13]
!70 = metadata !{i32 786689, metadata !62, metadata !"name", metadata !64, i32 50331661, metadata !41, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [name] [line 13]
!71 = metadata !{i32 786688, metadata !62, metadata !"x", metadata !64, i32 14, metadata !8, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x] [line 14]
!72 = metadata !{i32 786449, metadata !73, i32 1, metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !74, metadata !2, metadata !2, metadata !""} ; [ DW_TA
!73 = metadata !{metadata !"/home/ubuntu/klee/runtime/Intrinsic/memcpy.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!74 = metadata !{metadata !75}
!75 = metadata !{i32 786478, metadata !76, metadata !77, metadata !"memcpy", metadata !"memcpy", metadata !"", i32 12, metadata !78, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i8*, i64)* @memcpy, null, null, metadata !84, i32 12} 
!76 = metadata !{metadata !"memcpy.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!77 = metadata !{i32 786473, metadata !76}        ; [ DW_TAG_file_type ] [/home/ubuntu/klee/runtime/Intrinsic/memcpy.c]
!78 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !79, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!79 = metadata !{metadata !80, metadata !80, metadata !81, metadata !83}
!80 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, null} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!81 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !82} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!82 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from ]
!83 = metadata !{i32 786454, metadata !76, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !18} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!84 = metadata !{metadata !85, metadata !86, metadata !87, metadata !88, metadata !90}
!85 = metadata !{i32 786689, metadata !75, metadata !"destaddr", metadata !77, i32 16777228, metadata !80, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [destaddr] [line 12]
!86 = metadata !{i32 786689, metadata !75, metadata !"srcaddr", metadata !77, i32 33554444, metadata !81, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [srcaddr] [line 12]
!87 = metadata !{i32 786689, metadata !75, metadata !"len", metadata !77, i32 50331660, metadata !83, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [len] [line 12]
!88 = metadata !{i32 786688, metadata !75, metadata !"dest", metadata !77, i32 13, metadata !89, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dest] [line 13]
!89 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !43} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from char]
!90 = metadata !{i32 786688, metadata !75, metadata !"src", metadata !77, i32 14, metadata !41, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [src] [line 14]
!91 = metadata !{i32 786449, metadata !92, i32 1, metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !93, metadata !2, metadata !2, metadata !""} ; [ DW_TA
!92 = metadata !{metadata !"/home/ubuntu/klee/runtime/Intrinsic/memmove.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!93 = metadata !{metadata !94}
!94 = metadata !{i32 786478, metadata !95, metadata !96, metadata !"memmove", metadata !"memmove", metadata !"", i32 12, metadata !97, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i8*, i64)* @memmove, null, null, metadata !100, i32 
!95 = metadata !{metadata !"memmove.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!96 = metadata !{i32 786473, metadata !95}        ; [ DW_TAG_file_type ] [/home/ubuntu/klee/runtime/Intrinsic/memmove.c]
!97 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !98, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!98 = metadata !{metadata !80, metadata !80, metadata !81, metadata !99}
!99 = metadata !{i32 786454, metadata !95, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !18} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!100 = metadata !{metadata !101, metadata !102, metadata !103, metadata !104, metadata !105}
!101 = metadata !{i32 786689, metadata !94, metadata !"dst", metadata !96, i32 16777228, metadata !80, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [dst] [line 12]
!102 = metadata !{i32 786689, metadata !94, metadata !"src", metadata !96, i32 33554444, metadata !81, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [src] [line 12]
!103 = metadata !{i32 786689, metadata !94, metadata !"count", metadata !96, i32 50331660, metadata !99, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [count] [line 12]
!104 = metadata !{i32 786688, metadata !94, metadata !"a", metadata !96, i32 13, metadata !89, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [a] [line 13]
!105 = metadata !{i32 786688, metadata !94, metadata !"b", metadata !96, i32 14, metadata !41, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [b] [line 14]
!106 = metadata !{i32 786449, metadata !107, i32 1, metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !108, metadata !2, metadata !2, metadata !""} ; [ DW
!107 = metadata !{metadata !"/home/ubuntu/klee/runtime/Intrinsic/mempcpy.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!108 = metadata !{metadata !109}
!109 = metadata !{i32 786478, metadata !110, metadata !111, metadata !"mempcpy", metadata !"mempcpy", metadata !"", i32 11, metadata !112, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i8*, i64)* @mempcpy, null, null, metadata !115, 
!110 = metadata !{metadata !"mempcpy.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!111 = metadata !{i32 786473, metadata !110}      ; [ DW_TAG_file_type ] [/home/ubuntu/klee/runtime/Intrinsic/mempcpy.c]
!112 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !113, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!113 = metadata !{metadata !80, metadata !80, metadata !81, metadata !114}
!114 = metadata !{i32 786454, metadata !110, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !18} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!115 = metadata !{metadata !116, metadata !117, metadata !118, metadata !119, metadata !120}
!116 = metadata !{i32 786689, metadata !109, metadata !"destaddr", metadata !111, i32 16777227, metadata !80, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [destaddr] [line 11]
!117 = metadata !{i32 786689, metadata !109, metadata !"srcaddr", metadata !111, i32 33554443, metadata !81, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [srcaddr] [line 11]
!118 = metadata !{i32 786689, metadata !109, metadata !"len", metadata !111, i32 50331659, metadata !114, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [len] [line 11]
!119 = metadata !{i32 786688, metadata !109, metadata !"dest", metadata !111, i32 12, metadata !89, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dest] [line 12]
!120 = metadata !{i32 786688, metadata !109, metadata !"src", metadata !111, i32 13, metadata !41, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [src] [line 13]
!121 = metadata !{i32 786449, metadata !122, i32 1, metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !123, metadata !2, metadata !2, metadata !""} ; [ DW
!122 = metadata !{metadata !"/home/ubuntu/klee/runtime/Intrinsic/memset.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!123 = metadata !{metadata !124}
!124 = metadata !{i32 786478, metadata !125, metadata !126, metadata !"memset", metadata !"memset", metadata !"", i32 11, metadata !127, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i32, i64)* @memset, null, null, metadata !130, i32
!125 = metadata !{metadata !"memset.c", metadata !"/home/ubuntu/klee/runtime/Intrinsic"}
!126 = metadata !{i32 786473, metadata !125}      ; [ DW_TAG_file_type ] [/home/ubuntu/klee/runtime/Intrinsic/memset.c]
!127 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !128, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!128 = metadata !{metadata !80, metadata !80, metadata !8, metadata !129}
!129 = metadata !{i32 786454, metadata !125, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !18} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!130 = metadata !{metadata !131, metadata !132, metadata !133, metadata !134}
!131 = metadata !{i32 786689, metadata !124, metadata !"dst", metadata !126, i32 16777227, metadata !80, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [dst] [line 11]
!132 = metadata !{i32 786689, metadata !124, metadata !"s", metadata !126, i32 33554443, metadata !8, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [s] [line 11]
!133 = metadata !{i32 786689, metadata !124, metadata !"count", metadata !126, i32 50331659, metadata !129, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [count] [line 11]
!134 = metadata !{i32 786688, metadata !124, metadata !"a", metadata !126, i32 12, metadata !135, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [a] [line 12]
!135 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !136} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!136 = metadata !{i32 786485, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !43} ; [ DW_TAG_volatile_type ] [line 0, size 0, align 0, offset 0] [from char]
!137 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!138 = metadata !{i32 1, metadata !"Debug Info Version", i32 1}
!139 = metadata !{metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)"}
!140 = metadata !{i32 8, i32 0, metadata !4, null} ; [ DW_TAG_imported_declaration ]
!141 = metadata !{i32 10, i32 0, metadata !4, null}
!142 = metadata !{i32 14, i32 0, metadata !12, null}
!143 = metadata !{i32 17, i32 0, metadata !144, null}
!144 = metadata !{i32 786443, metadata !13, metadata !12, i32 17, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/klee_choose.c]
!145 = metadata !{metadata !146, metadata !146, i64 0}
!146 = metadata !{metadata !"long", metadata !147, i64 0}
!147 = metadata !{metadata !"omnipotent char", metadata !148, i64 0}
!148 = metadata !{metadata !"Simple C/C++ TBAA"}
!149 = metadata !{i32 18, i32 0, metadata !144, null}
!150 = metadata !{i32 19, i32 0, metadata !12, null}
!151 = metadata !{i32 13, i32 0, metadata !152, null}
!152 = metadata !{i32 786443, metadata !26, metadata !25, i32 13, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/klee_div_zero_check.c]
!153 = metadata !{i32 14, i32 0, metadata !152, null}
!154 = metadata !{i32 15, i32 0, metadata !25, null}
!155 = metadata !{i32 15, i32 0, metadata !36, null}
!156 = metadata !{i32 16, i32 0, metadata !36, null}
!157 = metadata !{metadata !158, metadata !158, i64 0}
!158 = metadata !{metadata !"int", metadata !147, i64 0}
!159 = metadata !{i32 21, i32 0, metadata !160, null}
!160 = metadata !{i32 786443, metadata !51, metadata !50, i32 21, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/klee_overshift_check.c]
!161 = metadata !{i32 27, i32 0, metadata !162, null}
!162 = metadata !{i32 786443, metadata !51, metadata !160, i32 21, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/klee_overshift_check.c]
!163 = metadata !{i32 29, i32 0, metadata !50, null}
!164 = metadata !{i32 16, i32 0, metadata !165, null}
!165 = metadata !{i32 786443, metadata !63, metadata !62, i32 16, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/klee_range.c]
!166 = metadata !{i32 17, i32 0, metadata !165, null}
!167 = metadata !{i32 19, i32 0, metadata !168, null}
!168 = metadata !{i32 786443, metadata !63, metadata !62, i32 19, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/klee_range.c]
!169 = metadata !{i32 22, i32 0, metadata !170, null}
!170 = metadata !{i32 786443, metadata !63, metadata !168, i32 21, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/klee_range.c]
!171 = metadata !{i32 25, i32 0, metadata !172, null}
!172 = metadata !{i32 786443, metadata !63, metadata !170, i32 25, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/klee_range.c]
!173 = metadata !{i32 26, i32 0, metadata !174, null}
!174 = metadata !{i32 786443, metadata !63, metadata !172, i32 25, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/klee_range.c]
!175 = metadata !{i32 27, i32 0, metadata !174, null}
!176 = metadata !{i32 28, i32 0, metadata !177, null}
!177 = metadata !{i32 786443, metadata !63, metadata !172, i32 27, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/klee_range.c]
!178 = metadata !{i32 29, i32 0, metadata !177, null}
!179 = metadata !{i32 32, i32 0, metadata !170, null}
!180 = metadata !{i32 34, i32 0, metadata !62, null}
!181 = metadata !{i32 16, i32 0, metadata !75, null}
!182 = metadata !{i32 17, i32 0, metadata !75, null}
!183 = metadata !{metadata !183, metadata !184, metadata !185}
!184 = metadata !{metadata !"llvm.vectorizer.width", i32 1}
!185 = metadata !{metadata !"llvm.vectorizer.unroll", i32 1}
!186 = metadata !{metadata !147, metadata !147, i64 0}
!187 = metadata !{metadata !187, metadata !184, metadata !185}
!188 = metadata !{i32 18, i32 0, metadata !75, null}
!189 = metadata !{i32 16, i32 0, metadata !190, null}
!190 = metadata !{i32 786443, metadata !95, metadata !94, i32 16, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/memmove.c]
!191 = metadata !{i32 19, i32 0, metadata !192, null}
!192 = metadata !{i32 786443, metadata !95, metadata !94, i32 19, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/memmove.c]
!193 = metadata !{i32 20, i32 0, metadata !194, null}
!194 = metadata !{i32 786443, metadata !95, metadata !192, i32 19, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/memmove.c]
!195 = metadata !{metadata !195, metadata !184, metadata !185}
!196 = metadata !{metadata !196, metadata !184, metadata !185}
!197 = metadata !{i32 22, i32 0, metadata !198, null}
!198 = metadata !{i32 786443, metadata !95, metadata !192, i32 21, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/home/ubuntu/klee/runtime/Intrinsic/memmove.c]
!199 = metadata !{i32 24, i32 0, metadata !198, null}
!200 = metadata !{i32 23, i32 0, metadata !198, null}
!201 = metadata !{metadata !201, metadata !184, metadata !185}
!202 = metadata !{metadata !202, metadata !184, metadata !185}
!203 = metadata !{i32 28, i32 0, metadata !94, null}
!204 = metadata !{i32 15, i32 0, metadata !109, null}
!205 = metadata !{i32 16, i32 0, metadata !109, null}
!206 = metadata !{metadata !206, metadata !184, metadata !185}
!207 = metadata !{metadata !207, metadata !184, metadata !185}
!208 = metadata !{i32 17, i32 0, metadata !109, null}
!209 = metadata !{i32 13, i32 0, metadata !124, null}
!210 = metadata !{i32 14, i32 0, metadata !124, null}
!211 = metadata !{i32 15, i32 0, metadata !124, null}

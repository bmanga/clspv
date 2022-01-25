
; RUN: clspv-opt -ReplaceOpenCLBuiltin -hack-clamp-width %s -o %t.ll
; RUN: FileCheck %s < %t.ll

; AUTO-GENERATED TEST FILE
; This test was generated by mad_sat_hack_clamp_test_gen.cpp.
; Please modify the that file and regenerate the tests to make changes.

target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "spir-unknown-unknown"

define <2 x i16> @mad_sat_ushort2(<2 x i16> %a, <2 x i16> %b, <2 x i16> %c) {
entry:
 %call = call <2 x i16> @_Z7mad_satDv2_tS_S_(<2 x i16> %a, <2 x i16> %b, <2 x i16> %c)
 ret <2 x i16> %call
}

declare <2 x i16> @_Z7mad_satDv2_tS_S_(<2 x i16>, <2 x i16>, <2 x i16>)

; CHECK: [[mul_ext:%[a-zA-Z0-9_.]+]] = call { <2 x i16>, <2 x i16> } @_Z8spirv.op.151.{{.*}}(i32 151, <2 x i16> %a, <2 x i16> %b)
; CHECK: [[mul_lo:%[a-zA-Z0-9_.]+]] = extractvalue { <2 x i16>, <2 x i16> } [[mul_ext]], 0
; CHECK: [[mul_hi:%[a-zA-Z0-9_.]+]] = extractvalue { <2 x i16>, <2 x i16> } [[mul_ext]], 1
; CHECK: [[add:%[a-zA-Z0-9_.]+]] = call { <2 x i16>, <2 x i16> } @_Z8spirv.op.149.{{.*}}(i32 149, <2 x i16> [[mul_lo]], <2 x i16> %c)
; CHECK: [[ex0:%[a-zA-Z0-9_.]+]] = extractvalue { <2 x i16>, <2 x i16> } [[add]], 0
; CHECK: [[ex1:%[a-zA-Z0-9_.]+]] = extractvalue { <2 x i16>, <2 x i16> } [[add]], 1
; CHECK: [[or:%[a-zA-Z0-9_.]+]] = or <2 x i16> [[mul_hi]], [[ex1]]
; CHECK: [[cmp:%[a-zA-Z0-9_.]+]] = icmp eq <2 x i16> [[or]], zeroinitializer
; CHECK: [[sel:%[a-zA-Z0-9_.]+]] = select <2 x i1> [[cmp]], <2 x i16> [[ex0]], <2 x i16> <i16 -1, i16 -1>
; CHECK: ret <2 x i16> [[sel]]

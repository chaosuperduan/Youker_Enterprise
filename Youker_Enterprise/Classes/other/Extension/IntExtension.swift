//
//  IntExtension.swift
//  youke
//
//  Created by keelon on 2018/6/6.
//  Copyright © 2018年 M2Micro. All rights reserved.
//

import Foundation
extension Int {
    public var toU8: UInt8{ get{return UInt8(truncatingIfNeeded:self)} }
    public var to8: Int8{ get{return Int8(truncatingIfNeeded:self)} }
    //public var toU16: UInt16{get{return UInt16(truncatingIfNeededtruncatingIfNeeded:self)}}
    public var to16: Int16{get{return Int16(truncatingIfNeeded:self)}}
    public var toU32: UInt32{get{return UInt32(truncatingIfNeeded:self)}}
    public var to32: Int32{get{return Int32(truncatingIfNeeded:self)}}
    public var toU64: UInt64{get{
        return UInt64(self) //No difference if the platform is 32 or 64
        }}
    public var to64: Int64{get{
        return Int64(self) //No difference if the platform is 32 or 64
        }}
}

extension Int32 {
    public var toU8: UInt8{ get{return UInt8(truncatingIfNeeded:self)} }
    public var to8: Int8{ get{return Int8(truncatingIfNeeded:self)} }
    public var toU16: UInt16{get{return UInt16(truncatingIfNeeded:self)}}
    //public var to16: Int16{get{return Int16(truncatingIfNeededtruncatingIfNeeded:self)}}
    public var toU32: UInt32{get{return UInt32(self)}}
    public var to32: Int32{get{return self}}
    public var toU64: UInt64{get{
        return UInt64(self) //No difference if the platform is 32 or 64
        }}
    public var to64: Int64{get{
        return Int64(self) //No difference if the platform is 32 or 64
        }}
}

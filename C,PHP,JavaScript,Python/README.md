# How to translate this Pascal code to C, C++, Python, Java, JavaScript etc.

## Data types

Byte = UInt8

Word = UInt16

Cardinal = UInt32

QWord = UInt64

LongInt = Int32

Integer = platform specific Int

## Bitwise operators

xor = ^

and = &

shl = <<

shr = >>

not = !

## Function parameters

In every class there is a function like this:

    procedure THasher[...].Update(Msg: PByte; Length: Integer);

you can replace "Msg: PByte" in your translation with something like "Msg: String"

and then replace all "Msg^" with "Msg[i]"

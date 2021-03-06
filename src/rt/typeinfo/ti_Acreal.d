/**
 * TypeInfo support code.
 *
 * Copyright: Copyright Digital Mars 2004 - 2009.
 * License:   $(WEB www.boost.org/LICENSE_1_0.txt, Boost License 1.0).
 * Authors:   Walter Bright
 */

/*          Copyright Digital Mars 2004 - 2009.
 * Distributed under the Boost Software License, Version 1.0.
 *    (See accompanying file LICENSE or copy at
 *          http://www.boost.org/LICENSE_1_0.txt)
 */
module rt.typeinfo.ti_Acreal;

private import rt.typeinfo.ti_creal;
private import rt.util.hash;

// creal[]

class TypeInfo_Ac : TypeInfo_Array
{
    override bool opEquals(Object o) { return TypeInfo.opEquals(o); }

    override string toString() const { return "creal[]"; }

    override size_t getHash(in void* p) @trusted const
    {
        creal[] s = *cast(creal[]*)p;
        return rt.util.hash.hashOf(s.ptr, s.length * creal.sizeof);
    }

    override bool equals(in void* p1, in void* p2) const
    {
        creal[] s1 = *cast(creal[]*)p1;
        creal[] s2 = *cast(creal[]*)p2;
        size_t len = s1.length;

        if (len != s2.length)
            return 0;
        for (size_t u = 0; u < len; u++)
        {
            if (!TypeInfo_c._equals(s1[u], s2[u]))
                return false;
        }
        return true;
    }

    override int compare(in void* p1, in void* p2) const
    {
        creal[] s1 = *cast(creal[]*)p1;
        creal[] s2 = *cast(creal[]*)p2;
        size_t len = s1.length;

        if (s2.length < len)
            len = s2.length;
        for (size_t u = 0; u < len; u++)
        {
            int c = TypeInfo_c._compare(s1[u], s2[u]);
            if (c)
                return c;
        }
        if (s1.length < s2.length)
            return -1;
        else if (s1.length > s2.length)
            return 1;
        return 0;
    }

    override @property inout(TypeInfo) next() inout
    {
        return cast(inout)typeid(creal);
    }
}

# ----------- freetype.m4 ----------------
#
# Checks for:
#    * freetype library (-lfreetype)
#    * freetype headers (freetype2/freetype/freetype.h)
#    * whether a freetype test program can be compiled
# 
# Environment set:
#    * HAVE_FREETYPE
#
# Defines:
#    * HAVE_FREETYPE
#    * USE_FREETYPE
#
# Substitutes:
#

AC_DEFUN(RFX_CHECK_FREETYPE,
[
AC_CHECK_PROGS(FREETYPE_CONFIG, freetype-config,)
OLDCPPFLAGS="${CPPFLAGS}"
OLDLIBS="${LIBS}"
if test "x${FREETYPE_CONFIG}" != "x"; then
    CPPFLAGS="$CFLAGS "`freetype-config --cflags`
else if test -d /usr/include/freetype2; then
    CPPFLAGS="$CFLAGS -I/usr/include/freetype2"
else if test -d /usr/local/include/freetype2; then
    CPPFLAGS="$CFLAGS -I/usr/local/include/freetype2"
fi 
fi
fi
AC_CHECK_LIB(freetype, FT_Init_FreeType,HAVE_LIB_FREETYPE=1,)
AC_CHECK_HEADERS(freetype/freetype.h,HAVE_FREETYPE_FREETYPE_H=1)
if test "x${HAVE_LIB_FREETYPE}" != "x";then
if test "x${HAVE_FREETYPE_FREETYPE_H}" != "x";then
    HAVE_FREETYPE=1
fi
fi

if test "x${HAVE_FREETYPE}" = "x1"; then 
    if test "x{$FREETYPE_CONFIG}" != "x"; then
	LIBS="$LIBS "`freetype-config --libs`
    else
	LIBS="$LIBS -lfreetype"
    fi

    AC_MSG_CHECKING([whether we can compile the freetype test program])

    cat > conftest.c << EOF
#include <freetype/freetype.h>
#include <freetype/ftglyph.h>
#include <freetype/ftsnames.h>
#include <freetype/ttnameid.h>
#include <freetype/ftoutln.h>

int main()
{
    FT_Library ftlibrary;
    FT_Face face;
    FT_Error error;
    FT_ULong charcode;
    FT_UInt gindex;
    FT_Glyph glyph;
    FT_BBox bbox;
    FT_Matrix matrix;
    FT_UInt i;
    char* name = 0;
    char italic, bold;
   
    FT_Init_FreeType(&ftlibrary);
    FT_New_Face(ftlibrary, "filename", 0, &face);
    i = face->num_glyphs - 1;
    italic = face->style_flags&FT_STYLE_FLAG_ITALIC;
    bold = face->style_flags&FT_STYLE_FLAG_BOLD;
    FT_Get_Postscript_Name(face);
    FT_Get_Char_Index(face, 33);
    FT_Get_First_Char(face, &i);
    FT_Get_Next_Char(face, 33, &i);
    if(FT_HAS_GLYPH_NAMES(face)) {
	FT_Get_Glyph_Name(face, 33, name, 127);
    }
    FT_Load_Glyph(face, 33, FT_LOAD_NO_BITMAP|FT_LOAD_NO_SCALE);
    FT_Get_Glyph(face->glyph, &glyph);
    FT_Glyph_Get_CBox(glyph, ft_glyph_bbox_unscaled, &bbox);
    FT_Done_Glyph(glyph);
    FT_Done_Face(face);
    FT_Done_FreeType(ftlibrary);
    return 0;
}
EOF

    ac_link='$CC $CPPFLAGS $CFLAGS conftest.c $LIBS -o conftest${ac_exeext}'
    if { (eval echo freetype.m4:71: \"$ac_link\") 1>&5; (eval $ac_link) 2>&5; } && test -s conftest${ac_exeext}; then
	AC_MSG_RESULT(yes)
	AC_DEFINE_UNQUOTED(HAVE_FREETYPE, 1)
	AC_DEFINE_UNQUOTED(USE_FREETYPE, 1)  # for ttf2tp1
    else
	echo "configure: failed program was:" >&5
	cat conftest.c >&5
	HAVE_FREETYPE=0
	AC_MSG_RESULT(no)
    fi
    rm -f conftest*
fi

# if the above didn't work out, reset all changes to the compiler variables.
if test "x${HAVE_FREETYPE}" "!=" "x1"; then 
    CPPFLAGS=$OLDCPPFLAGS
    LIBS=$OLDLIBS
fi 
])


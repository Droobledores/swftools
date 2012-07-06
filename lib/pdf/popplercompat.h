#ifndef __popplercompat_h__
#define __popplercompat_h__

#include "../../config.h"

char* mktmpname(char*ptr);

#ifdef HAVE_POPPLER
  #define int type int type
  #define type type
#else
  #define int type
  #define type
#endif

#ifdef HAVE_POPPLER
  #define POPPLER_TILING_PATTERN_CATALOG Catalog *cat,
  #define POPPLER_TILING_PATTERN_CATALOG_ARG cat,
  #define POPPLER_TILING_PATTERN_PMAT double *pmat,
  #define POPPLER_TILING_PATTERN_PMAT_ARG pmat,
  #define POPPLER_TILING_PATTERN_TILING_TYPE int tilingType,
  #define POPPLER_TILING_PATTERN_TILING_TYPE_ARG tilingType,
#else
  #define POPPLER_TILING_PATTERN_CATALOG
  #define POPPLER_TILING_PATTERN_CATALOG_ARG
  #define POPPLER_TILING_PATTERN_PMAT
  #define POPPLER_TILING_PATTERN_PMAT_ARG
  #define POPPLER_TILING_PATTERN_TILING_TYPE
  #define POPPLER_TILING_PATTERN_TILING_TYPE_ARG
#endif

#ifdef HAVE_POPPLER
  #define POPPLER_GET_GLYPH_ARGS , x0, y0, &clip, &clipRes
#else
  #define POPPLER_GET_GLYPH_ARGS
#endif

#ifndef HAVE_POPPLER
  #define GFXSplashOutputDev SplashOutputDev
#endif

#ifdef HAVE_POPPLER
  #define POPPLER_CHECK_PAGE_SLICE_ANNOT_CBK_H , GBool (*annotDisplayDecideCbk)(Annot *annot, void *user_data) = NULL
  #define POPPLER_CHECK_PAGE_SLICE_ANNOT_CBK , GBool (*annotDisplayDecideCbk)(Annot *annot, void *user_data)
  #define POPPLER_CHECK_PAGE_SLICE_ANNOT_CBK_DATA_H , void *annotDisplayDecideCbkData = NULL
  #define POPPLER_CHECK_PAGE_SLICE_ANNOT_CBK_DATA , void *annotDisplayDecideCbkData
#else
  #define POPPLER_CHECK_PAGE_SLICE_ANNOT_CBK_H
  #define POPPLER_CHECK_PAGE_SLICE_ANNOT_CBK
  #define POPPLER_CHECK_PAGE_SLICE_ANNOT_CBK_DATA_H
  #define POPPLER_CHECK_PAGE_SLICE_ANNOT_CBK_DATA
#endif

#ifdef HAVE_POPPLER
  #define POPPLER_COPY_STATE_PATH gTrue
#else
  #define POPPLER_COPY_STATE_PATH gFalse
#endif

#ifdef HAVE_POPPLER
  #define GFXGlobalParams GlobalParams
#endif

#include <goo/GooString.h>
#include <goo/gfile.h>
#include <Object.h>
#include <Stream.h>
#include <Array.h>
#include <Dict.h>
#include <XRef.h>
#include <Catalog.h>
#include <Page.h>
#include <PDFDoc.h>
#include <Error.h>
#include <Link.h>
#include <OutputDev.h>
#include <GfxFont.h>
#include <GfxState.h>
#include <GlobalParams.h>

#endif

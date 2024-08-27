/*****************************************************************************
  В модуле определены пути до библиотеки FFmpeg

*****************************************************************************/

import qbs
import '../LibModule.qbs' as LibModule

LibModule {
    version: "4.x"
    prefix: "/opt/ffmpeg"
    checkingHeaders: [
        "libavcodec/avcodec.h",
        "libavdevice/avdevice.h",
        "libavfilter/avfilter.h",
        "libavformat/avformat.h",
        "libavutil/avutil.h",
        "libswresample/swresample.h",
        "libswscale/swscale.h",
    ]
}

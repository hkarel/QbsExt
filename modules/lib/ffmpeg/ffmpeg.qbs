/*****************************************************************************
  В модуле определены пути до библиотеки FFmpeg

*****************************************************************************/

import qbs
import '../LibModule.qbs' as LibModule

LibModule {
    id: ffmpeg
    version: "3.0.x"
    prefix: "/opt/ffmpeg"
    checkingHeaders: [
        "libavcodec/avcodec.h",
        "libavdevice/avdevice.h",
        "libavfilter/avfilter.h",
        "libavformat/avformat.h",
        "libavresample/avresample.h",
        "libavutil/avutil.h",
        "libpostproc/postprocess.h",
        "libswresample/swresample.h",
        "libswscale/swscale.h",
    ]
}

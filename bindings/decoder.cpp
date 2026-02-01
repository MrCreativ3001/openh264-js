#include "../openh264/codec/api/wels/codec_api.h"

extern "C" long openh264_decoder_create(ISVCDecoder **outDecoder) {
  ISVCDecoder *decoder;
  long error = WelsCreateDecoder(&decoder);
  if (error != 0) {
    return error;
  }

  SDecodingParam params = {0};
  params.uiTargetDqLayer = 1;
  params.eEcActiveIdc = ERROR_CON_SLICE_COPY;
  params.bParseOnly = false;
  params.sVideoProperty.eVideoBsType = VIDEO_BITSTREAM_DEFAULT;

  error = decoder->Initialize(&params);
  if (error != 0) {
    WelsDestroyDecoder(*outDecoder);
    return error;
  }

  decoder->SetOption(DECODER_OPTION_NUM_OF_THREADS, 0);

  *outDecoder = decoder;

  return 0;
}

extern "C" long openh264_decoder_decode(ISVCDecoder *decoder,
                                        unsigned char *frame, int frameLen,
                                        unsigned char **output, int outputLen,
                                        int *outWidth, int *outHeight,
                                        bool *outFrameReady) {
  SBufferInfo info;

  long error = decoder->DecodeFrameNoDelay(frame, frameLen, output, &info);

  return error;
}

extern "C" void openh264_decoder_destroy(ISVCDecoder *decoder) {
  decoder->Uninitialize();
  WelsDestroyDecoder(decoder);
}
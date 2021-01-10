import 'dart:ffi' as ffi;
import 'dart:typed_data';

import 'package:ffi/ffi.dart' as ffi;

import 'bindings.dart';
import 'enums.dart';
import 'flags.dart';
import 'mem.dart' as ffi;

class _WGPUType<T extends ffi.NativeType> {
  final ffi.Pointer<T> _ptr;
  final bool _own;

  _WGPUType._({
    required ffi.Pointer<T> ptr,
    required bool own,
    bool? init,
    ffi.Pointer<T>? copy,
  })  : assert(ptr != ffi.nullptr),
        _ptr = ptr,
        _own = own {
    if (init ?? false == true) {
      ffi.memset(_ptr, 0, ffi.sizeOf<T>());
    }
    if (copy != null) {
      ffi.memcpy(_ptr, copy, ffi.sizeOf<T>());
    }
  }

  _WGPUType._adopt(ffi.Pointer<T> ptr) : this._(ptr: ptr, own: false);

  _WGPUType._alloc() : this._(ptr: ffi.allocate<T>(), own: true, init: true);

  _WGPUType._copy(ffi.Pointer<T> ptr)
      : this._(ptr: ffi.allocate<T>(), own: true, copy: ptr);

  void dispose() {
    if (_own) ffi.free(_ptr);
  }

  ffi.Pointer<T> toNative() => _ptr;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _WGPUType &&
        (_ptr == other._ptr ||
            ffi.memcmp(_ptr, other._ptr, ffi.sizeOf<T>()) == 0);
  }

  @override
  int get hashCode => _ptr.hashCode;

  @override
  String toString() => '$runtimeType($_ptr)';
}

class AdapterInfo extends _WGPUType<WGPUCAdapterInfo> {
  AdapterInfo() : super._alloc();
  AdapterInfo.fromNative(ffi.Pointer<WGPUCAdapterInfo> ptr) : super._adopt(ptr);
  AdapterInfo._copy(ffi.Pointer<WGPUCAdapterInfo> ptr) : super._copy(ptr);

  AdapterInfo copy() => AdapterInfo._copy(_ptr);

  WGPUCAdapterInfo get _ref => _ptr.ref;

  /// Adapter name
  String get name {
    return ffi.Utf8.fromUtf8(_ref.name.cast(), length: _ref.name_length);
  }

  /// Vendor PCI id of the adapter
  int get vendor => _ref.vendor;

  /// PCI id of the adapter
  int get device => _ref.device;

  /// Type of device
  DeviceType get deviceType => DeviceType.values[_ref.device_type];

  /// Backend used for device
  int get backend => _ref.backend;
}

class ChainedStruct extends _WGPUType<WGPUChainedStruct> {
  ChainedStruct() : super._alloc();
  ChainedStruct.fromNative(ffi.Pointer<WGPUChainedStruct> ptr)
      : super._adopt(ptr);
  ChainedStruct._copy(ffi.Pointer<WGPUChainedStruct> ptr) : super._copy(ptr);

  ChainedStruct copy() => ChainedStruct._copy(_ptr);
}

class ComputePass extends _WGPUType<WGPUComputePass> {
  ComputePass() : super._alloc();
  ComputePass.fromNative(ffi.Pointer<WGPUComputePass> ptr) : super._adopt(ptr);
  ComputePass._copy(ffi.Pointer<WGPUComputePass> ptr) : super._copy(ptr);

  ComputePass copy() => ComputePass._copy(_ptr);
}

class ComputePassDescriptor extends _WGPUType<WGPUComputePassDescriptor> {
  ComputePassDescriptor() : super._alloc();
  ComputePassDescriptor.fromNative(ffi.Pointer<WGPUComputePassDescriptor> ptr)
      : super._adopt(ptr);
  ComputePassDescriptor._copy(ffi.Pointer<WGPUComputePassDescriptor> ptr)
      : super._copy(ptr);

  ComputePassDescriptor copy() => ComputePassDescriptor._copy(_ptr);

  WGPUComputePassDescriptor get _ref => _ptr.ref;

  int get todo => _ref.todo;
}

/// RGBA double precision color.
///
/// This is not to be used as a generic color type, only for specific wgpu interfaces.
class Color extends _WGPUType<WGPUColor> {
  Color() : super._alloc();
  Color.fromNative(ffi.Pointer<WGPUColor> ptr) : super._adopt(ptr);
  Color._copy(ffi.Pointer<WGPUColor> ptr) : super._copy(ptr);

  Color copy() => Color._copy(_ptr);

  /// ### TODO: replace with dart:ui Color?
  WGPUColor get _ref => _ptr.ref;

  double get red => _ref.r;
  double get green => _ref.g;
  double get blue => _ref.b;
  double get alpha => _ref.a;
}

class Limits extends _WGPUType<WGPUCLimits> {
  Limits() : super._alloc();
  Limits.fromNative(ffi.Pointer<WGPUCLimits> ptr) : super._adopt(ptr);
  Limits._copy(ffi.Pointer<WGPUCLimits> ptr) : super._copy(ptr);

  Limits copy() => Limits._copy(_ptr);

  WGPUCLimits get _ref => _ptr.ref;

  int get maxBindGroups => _ref.max_bind_groups;
}

class Option_BufferSize extends _WGPUType<WGPUOption_BufferSize> {
  Option_BufferSize() : super._alloc();
  Option_BufferSize.fromNative(ffi.Pointer<WGPUOption_BufferSize> ptr)
      : super._adopt(ptr);
  Option_BufferSize._copy(ffi.Pointer<WGPUOption_BufferSize> ptr)
      : super._copy(ptr);

  Option_BufferSize copy() => Option_BufferSize._copy(_ptr);
}

/// Describes an individual channel within a render pass, such as color, depth, or stencil.
class PassChannel_Color extends _WGPUType<WGPUPassChannel_Color> {
  PassChannel_Color() : super._alloc();
  PassChannel_Color.fromNative(ffi.Pointer<WGPUPassChannel_Color> ptr)
      : super._adopt(ptr);
  PassChannel_Color._copy(ffi.Pointer<WGPUPassChannel_Color> ptr)
      : super._copy(ptr);

  PassChannel_Color copy() => PassChannel_Color._copy(_ptr);

  WGPUPassChannel_Color get _ref => _ptr.ref;

  /// Operation to perform to the output attachment at the start of a renderpass. This must be clear if it
  /// is the first renderpass rendering to a swap chain image.
  LoadOp get loadOp => LoadOp.values[_ref.load_op];

  /// Operation to perform to the output attachment at the end of a renderpass.
  StoreOp get storeOp => StoreOp.values[_ref.store_op];

  /// If load_op is [`LoadOp::Clear`], the attachement will be cleared to this color.
  Color get clearValue => Color.fromNative(_ref.clear_value.addressOf);

  /// If true, the relevant channel is not changed by a renderpass, and the corresponding attachment
  /// can be used inside the pass by other read-only usages.
  bool get readOnly => _ref.read_only != 0;
}

class RenderBundleEncoder extends _WGPUType<WGPURenderBundleEncoder> {
  RenderBundleEncoder() : super._alloc();
  RenderBundleEncoder.fromNative(ffi.Pointer<WGPURenderBundleEncoder> ptr)
      : super._adopt(ptr);
  RenderBundleEncoder._copy(ffi.Pointer<WGPURenderBundleEncoder> ptr)
      : super._copy(ptr);

  RenderBundleEncoder copy() => RenderBundleEncoder._copy(_ptr);
}

class RenderPass extends _WGPUType<WGPURenderPass> {
  RenderPass() : super._alloc();
  RenderPass.fromNative(ffi.Pointer<WGPURenderPass> ptr) : super._adopt(ptr);
  RenderPass._copy(ffi.Pointer<WGPURenderPass> ptr) : super._copy(ptr);

  RenderPass copy() => RenderPass._copy(_ptr);
}

/// Describes a color attachment to a [`RenderPass`].
// class WGPURenderPassColorAttachmentDescriptorBase_TextureViewId
//     extends ffi.Struct {
class RenderPassColorAttachmentDescriptorBase_TextureViewId extends _WGPUType<
    WGPURenderPassColorAttachmentDescriptorBase_TextureViewId> {
  RenderPassColorAttachmentDescriptorBase_TextureViewId() : super._alloc();
  RenderPassColorAttachmentDescriptorBase_TextureViewId.fromNative(
      ffi.Pointer<WGPURenderPassColorAttachmentDescriptorBase_TextureViewId>
          ptr)
      : super._adopt(ptr);
  RenderPassColorAttachmentDescriptorBase_TextureViewId._copy(
      ffi.Pointer<WGPURenderPassColorAttachmentDescriptorBase_TextureViewId>
          ptr)
      : super._copy(ptr);

  RenderPassColorAttachmentDescriptorBase_TextureViewId copy() =>
      RenderPassColorAttachmentDescriptorBase_TextureViewId._copy(_ptr);

  WGPURenderPassColorAttachmentDescriptorBase_TextureViewId get _ref =>
      _ptr.ref;

  /// Texture attachment to render to. Must contain [`TextureUsage::OUTPUT_ATTACHMENT`].
  int get attachment => _ref.attachment;

  /// MSAA resolve target. Must contain [`TextureUsage::OUTPUT_ATTACHMENT`]. Must be `None` if
  /// attachment has 1 sample (does not have MSAA). This is not mandatory for rendering with multisampling,
  /// you can choose to resolve later or manually.
  int get resolve_target => _ref.resolve_target;

  /// Color channel.
  PassChannel_Color get channel =>
      PassChannel_Color.fromNative(_ref.channel.addressOf);
}

/// Describes an individual channel within a render pass, such as color, depth, or stencil.
class PassChannel_f32 extends _WGPUType<WGPUPassChannel_f32> {
  PassChannel_f32() : super._alloc();
  PassChannel_f32.fromNative(ffi.Pointer<WGPUPassChannel_f32> ptr)
      : super._adopt(ptr);
  PassChannel_f32._copy(ffi.Pointer<WGPUPassChannel_f32> ptr)
      : super._copy(ptr);

  PassChannel_f32 copy() => PassChannel_f32._copy(_ptr);

  WGPUPassChannel_f32 get _ref => _ptr.ref;

  /// Operation to perform to the output attachment at the start of a renderpass. This must be clear if it
  /// is the first renderpass rendering to a swap chain image.
  LoadOp get loadOp => LoadOp.values[_ref.load_op];

  /// Operation to perform to the output attachment at the end of a renderpass.
  StoreOp get storeOp => StoreOp.values[_ref.store_op];

  /// If load_op is [`LoadOp::Clear`], the attachement will be cleared to this color.
  double get clearValue => _ref.clear_value;

  /// If true, the relevant channel is not changed by a renderpass, and the corresponding attachment
  /// can be used inside the pass by other read-only usages.
  bool get readOnly => _ref.read_only != 0;
}

/// Describes an individual channel within a render pass, such as color, depth, or stencil.
class PassChannel_u32 extends _WGPUType<WGPUPassChannel_u32> {
  PassChannel_u32() : super._alloc();
  PassChannel_u32.fromNative(ffi.Pointer<WGPUPassChannel_u32> ptr)
      : super._adopt(ptr);
  PassChannel_u32._copy(ffi.Pointer<WGPUPassChannel_u32> ptr)
      : super._copy(ptr);

  PassChannel_u32 copy() => PassChannel_u32._copy(_ptr);

  WGPUPassChannel_u32 get _ref => _ptr.ref;

  /// Operation to perform to the output attachment at the start of a renderpass. This must be clear if it
  /// is the first renderpass rendering to a swap chain image.
  LoadOp get loadOp => LoadOp.values[_ref.load_op];

  /// Operation to perform to the output attachment at the end of a renderpass.
  StoreOp get storeOp => StoreOp.values[_ref.store_op];

  /// If load_op is [`LoadOp::Clear`], the attachement will be cleared to this color.
  int get clearValue => _ref.clear_value;

  /// If true, the relevant channel is not changed by a renderpass, and the corresponding attachment
  /// can be used inside the pass by other read-only usages.
  bool get readOnly => _ref.read_only != 0;
}

/// Describes a depth/stencil attachment to a [`RenderPass`].
class RenderPassDepthStencilAttachmentDescriptorBase_TextureViewId
    extends _WGPUType<
        WGPURenderPassDepthStencilAttachmentDescriptorBase_TextureViewId> {
  RenderPassDepthStencilAttachmentDescriptorBase_TextureViewId()
      : super._alloc();
  RenderPassDepthStencilAttachmentDescriptorBase_TextureViewId.fromNative(
      ffi.Pointer<
              WGPURenderPassDepthStencilAttachmentDescriptorBase_TextureViewId>
          ptr)
      : super._adopt(ptr);
  RenderPassDepthStencilAttachmentDescriptorBase_TextureViewId._copy(
      ffi.Pointer<
              WGPURenderPassDepthStencilAttachmentDescriptorBase_TextureViewId>
          ptr)
      : super._copy(ptr);

  RenderPassDepthStencilAttachmentDescriptorBase_TextureViewId copy() =>
      RenderPassDepthStencilAttachmentDescriptorBase_TextureViewId._copy(_ptr);

  WGPURenderPassDepthStencilAttachmentDescriptorBase_TextureViewId get _ref =>
      _ptr.ref;

  /// Texture attachment to render to. Must contain [`TextureUsage::OUTPUT_ATTACHMENT`] and be a valid
  /// texture type for a depth/stencil attachment.
  int get attachment => _ref.attachment;

  /// Depth channel.
  PassChannel_f32 get depth => PassChannel_f32.fromNative(_ref.depth.addressOf);

  /// Stencil channel.
  PassChannel_u32 get stencil =>
      PassChannel_u32.fromNative(_ref.stencil.addressOf);
}

class RenderPassDescriptor extends _WGPUType<WGPURenderPassDescriptor> {
  RenderPassDescriptor() : super._alloc();
  RenderPassDescriptor.fromNative(ffi.Pointer<WGPURenderPassDescriptor> ptr)
      : super._adopt(ptr);
  RenderPassDescriptor._copy(ffi.Pointer<WGPURenderPassDescriptor> ptr)
      : super._copy(ptr);

  RenderPassDescriptor copy() => RenderPassDescriptor._copy(_ptr);

  WGPURenderPassDescriptor get _ref => _ptr.ref;

  List<RenderPassColorAttachmentDescriptorBase_TextureViewId>
      get colorAttachments {
    // ### TODO: lazy iterable
    var attachments = <RenderPassColorAttachmentDescriptorBase_TextureViewId>[];
    for (var i = 0; i < _ref.color_attachments_length; ++i) {
      attachments.add(
          RenderPassColorAttachmentDescriptorBase_TextureViewId.fromNative(
              _ref.color_attachments.elementAt(i)));
    }
    return attachments;
  }

  RenderPassDepthStencilAttachmentDescriptorBase_TextureViewId
      get depthStencilAttachent {
    return RenderPassDepthStencilAttachmentDescriptorBase_TextureViewId
        .fromNative(_ref.depth_stencil_attachment);
  }
}

/// Layout of a texture in a buffer's memory.
class TextureDataLayout extends _WGPUType<WGPUTextureDataLayout> {
  TextureDataLayout() : super._alloc();
  TextureDataLayout.fromNative(ffi.Pointer<WGPUTextureDataLayout> ptr)
      : super._adopt(ptr);
  TextureDataLayout._copy(ffi.Pointer<WGPUTextureDataLayout> ptr)
      : super._copy(ptr);

  TextureDataLayout copy() => TextureDataLayout._copy(_ptr);

  WGPUTextureDataLayout get _ref => _ptr.ref;

  /// Offset into the buffer that is the start of the texture. Must be a multiple of texture block size.
  /// For non-compressed textures, this is 1.
  int get offset => _ref.offset;

  /// Bytes per "row" of the image. This represents one row of pixels in the x direction. Compressed
  /// textures include multiple rows of pixels in each "row". May be 0 for 1D texture copies.
  ///
  /// Must be a multiple of 256 for [`CommandEncoder::copy_buffer_to_texture`] and [`CommandEncoder::copy_texture_to_buffer`].
  /// [`Queue::write_texture`] does not have this requirement.
  ///
  /// Must be a multiple of the texture block size. For non-compressed textures, this is 1.
  int get bytesPerRow => _ref.bytes_per_row;

  /// Rows that make up a single "image". Each "image" is one layer in the z direction of a 3D image. May be larger
  /// than `copy_size.y`.
  ///
  /// May be 0 for 2D texture copies.
  int get rowsPerImage => _ref.rows_per_image;
}

class BufferCopyView extends _WGPUType<WGPUBufferCopyView> {
  BufferCopyView() : super._alloc();
  BufferCopyView.fromNative(ffi.Pointer<WGPUBufferCopyView> ptr)
      : super._adopt(ptr);
  BufferCopyView._copy(ffi.Pointer<WGPUBufferCopyView> ptr) : super._copy(ptr);

  BufferCopyView copy() => BufferCopyView._copy(_ptr);

  WGPUBufferCopyView get _ref => _ptr.ref;

  int get buffer => _ref.buffer;

  //external WGPUTextureDataLayout layout;
  TextureDataLayout get layout =>
      TextureDataLayout.fromNative(_ref.layout.addressOf);
}

/// Origin of a copy to/from a texture.
class Origin3D extends _WGPUType<WGPUOrigin3d> {
  Origin3D() : super._alloc();
  Origin3D.fromNative(ffi.Pointer<WGPUOrigin3d> ptr) : super._adopt(ptr);
  Origin3D._copy(ffi.Pointer<WGPUOrigin3d> ptr) : super._copy(ptr);

  Origin3D copy() => Origin3D._copy(_ptr);

  WGPUOrigin3d get _ref => _ptr.ref;

  int get x => _ref.x;
  int get y => _ref.y;
  int get z => _ref.z;
}

class TextureCopyView extends _WGPUType<WGPUTextureCopyView> {
  TextureCopyView() : super._alloc();
  TextureCopyView.fromNative(ffi.Pointer<WGPUTextureCopyView> ptr)
      : super._adopt(ptr);
  TextureCopyView._copy(ffi.Pointer<WGPUTextureCopyView> ptr)
      : super._copy(ptr);

  TextureCopyView copy() => TextureCopyView._copy(_ptr);

  WGPUTextureCopyView get _ref => _ptr.ref;

  int get texture => _ref.texture;
  int get mipLevel => _ref.mip_level;
  Origin3D get origin => Origin3D.fromNative(_ref.origin.addressOf);
}

/// Extent of a texture related operation.
class Extent3D extends _WGPUType<WGPUExtent3d> {
  Extent3D() : super._alloc();
  Extent3D.fromNative(ffi.Pointer<WGPUExtent3d> ptr) : super._adopt(ptr);
  Extent3D._copy(ffi.Pointer<WGPUExtent3d> ptr) : super._copy(ptr);

  Extent3D copy() => Extent3D._copy(_ptr);

  WGPUExtent3d get _ref => _ptr.ref;

  int get width => _ref.width;
  int get height => _ref.height;
  int get depth => _ref.depth;
}

/// Describes a [`CommandBuffer`].
class CommandBufferDescriptor extends _WGPUType<WGPUCommandBufferDescriptor> {
  CommandBufferDescriptor() : super._alloc();
  CommandBufferDescriptor.fromNative(
      ffi.Pointer<WGPUCommandBufferDescriptor> ptr)
      : super._adopt(ptr);
  CommandBufferDescriptor._copy(ffi.Pointer<WGPUCommandBufferDescriptor> ptr)
      : super._copy(ptr);

  CommandBufferDescriptor copy() => CommandBufferDescriptor._copy(_ptr);

  WGPUCommandBufferDescriptor get _ref => _ptr.ref;

  /// Set this member to zero
  int get todo => _ref.todo;
}

class BindGroupEntry extends _WGPUType<WGPUBindGroupEntry> {
  BindGroupEntry() : super._alloc();
  BindGroupEntry.fromNative(ffi.Pointer<WGPUBindGroupEntry> ptr)
      : super._adopt(ptr);
  BindGroupEntry._copy(ffi.Pointer<WGPUBindGroupEntry> ptr) : super._copy(ptr);

  BindGroupEntry copy() => BindGroupEntry._copy(_ptr);

  WGPUBindGroupEntry get _ref => _ptr.ref;

  int get binding => _ref.binding;
  int get buffer => _ref.buffer;
  int get offset => _ref.offset;
  int get size => _ref.size;
  int get sampler => _ref.sampler;
  int get texture_view => _ref.texture_view;
}

class BindGroupDescriptor extends _WGPUType<WGPUBindGroupDescriptor> {
  BindGroupDescriptor() : super._alloc();
  BindGroupDescriptor.fromNative(ffi.Pointer<WGPUBindGroupDescriptor> ptr)
      : super._adopt(ptr);
  BindGroupDescriptor._copy(ffi.Pointer<WGPUBindGroupDescriptor> ptr)
      : super._copy(ptr);

  BindGroupDescriptor copy() => BindGroupDescriptor._copy(_ptr);

  WGPUBindGroupDescriptor get _ref => _ptr.ref;

  String get label => ffi.Utf8.fromUtf8(_ref.label.cast());
  int get layout => _ref.layout;

  List<BindGroupEntry> get entries {
    // ### TODO: lazy iterable
    var e = <BindGroupEntry>[];
    for (var i = 0; i < _ref.entries_length; ++i) {
      e.add(BindGroupEntry.fromNative(_ref.entries.elementAt(i)));
    }
    return e;
  }
}

class BindGroupLayoutEntry extends _WGPUType<WGPUBindGroupLayoutEntry> {
  BindGroupLayoutEntry() : super._alloc();
  BindGroupLayoutEntry.fromNative(ffi.Pointer<WGPUBindGroupLayoutEntry> ptr)
      : super._adopt(ptr);
  BindGroupLayoutEntry._copy(ffi.Pointer<WGPUBindGroupLayoutEntry> ptr)
      : super._copy(ptr);

  BindGroupLayoutEntry copy() => BindGroupLayoutEntry._copy(_ptr);

  WGPUBindGroupLayoutEntry get _ref => _ptr.ref;

  int get binding => _ref.binding;
  int get visibility => _ref.visibility;

  BindingType get ty => BindingType.values[_ref.ty];

  bool get hasDynamicOffset => _ref.has_dynamic_offset != 0;

  int get minBufferBindingSize => _ref.min_buffer_binding_size;

  bool get multisampled => _ref.multisampled != 0;

  TextureViewDimension get viewDimension =>
      TextureViewDimension.values[_ref.view_dimension];

  TextureComponentType get textureComponentType =>
      TextureComponentType.values[_ref.texture_component_type];

  TextureFormat get storageTextureFormat =>
      TextureFormat.values[_ref.storage_texture_format];

  int get count => _ref.count;
}

class BindGroupLayoutDescriptor
    extends _WGPUType<WGPUBindGroupLayoutDescriptor> {
  BindGroupLayoutDescriptor() : super._alloc();
  BindGroupLayoutDescriptor.fromNative(
      ffi.Pointer<WGPUBindGroupLayoutDescriptor> ptr)
      : super._adopt(ptr);
  BindGroupLayoutDescriptor._copy(
      ffi.Pointer<WGPUBindGroupLayoutDescriptor> ptr)
      : super._copy(ptr);

  BindGroupLayoutDescriptor copy() => BindGroupLayoutDescriptor._copy(_ptr);

  WGPUBindGroupLayoutDescriptor get _ref => _ptr.ref;

  String get label => ffi.Utf8.fromUtf8(_ref.label.cast());

  List<BindGroupLayoutEntry> get entries {
    // ### TODO: lazy iterable
    var e = <BindGroupLayoutEntry>[];
    for (var i = 0; i < _ref.entries_length; ++i) {
      e.add(BindGroupLayoutEntry.fromNative(_ref.entries.elementAt(i)));
    }
    return e;
  }
}

/// Describes a [`Buffer`].
class BufferDescriptor extends _WGPUType<WGPUBufferDescriptor> {
  BufferDescriptor() : super._alloc();
  BufferDescriptor.fromNative(ffi.Pointer<WGPUBufferDescriptor> ptr)
      : super._adopt(ptr);
  BufferDescriptor._copy(ffi.Pointer<WGPUBufferDescriptor> ptr)
      : super._copy(ptr);

  BufferDescriptor copy() => BufferDescriptor._copy(_ptr);

  WGPUBufferDescriptor get _ref => _ptr.ref;

  /// Debug label of a buffer. This will show up in graphics debuggers for easy identification.
  String get label => ffi.Utf8.fromUtf8(_ref.label.cast());

  /// Size of a buffer.
  int get size => _ref.size;

  /// Usages of a buffer. If the buffer is used in any way that isn't specified here, the operation
  /// will panic.
  int get usage => _ref.usage;

  /// Allows a buffer to be mapped immediately after they are made. It does not have to be [`BufferUsage::MAP_READ`] or
  /// [`BufferUsage::MAP_WRITE`], all buffers are allowed to be mapped at creation.
  bool get mappedAtCreation => _ref.mapped_at_creation != 0;
}

/// Describes a [`CommandEncoder`].
class CommandEncoderDescriptor extends _WGPUType<WGPUCommandEncoderDescriptor> {
  CommandEncoderDescriptor() : super._alloc();
  CommandEncoderDescriptor.fromNative(
      ffi.Pointer<WGPUCommandEncoderDescriptor> ptr)
      : super._adopt(ptr);
  CommandEncoderDescriptor._copy(ffi.Pointer<WGPUCommandEncoderDescriptor> ptr)
      : super._copy(ptr);

  CommandEncoderDescriptor copy() => CommandEncoderDescriptor._copy(_ptr);

  WGPUCommandEncoderDescriptor get _ref => _ptr.ref;

  /// Debug label for the command encoder. This will show up in graphics debuggers for easy identification.
  String get label => ffi.Utf8.fromUtf8(_ref.label.cast());
}

class ProgrammableStageDescriptor
    extends _WGPUType<WGPUProgrammableStageDescriptor> {
  ProgrammableStageDescriptor() : super._alloc();
  ProgrammableStageDescriptor.fromNative(
      ffi.Pointer<WGPUProgrammableStageDescriptor> ptr)
      : super._adopt(ptr);
  ProgrammableStageDescriptor._copy(
      ffi.Pointer<WGPUProgrammableStageDescriptor> ptr)
      : super._copy(ptr);

  ProgrammableStageDescriptor copy() => ProgrammableStageDescriptor._copy(_ptr);

  WGPUProgrammableStageDescriptor get _ref => _ptr.ref;

  int get module => _ref.module;

  String get entryPoint => ffi.Utf8.fromUtf8(_ref.entry_point.cast());
}

class ComputePipelineDescriptor
    extends _WGPUType<WGPUComputePipelineDescriptor> {
  ComputePipelineDescriptor() : super._alloc();
  ComputePipelineDescriptor.fromNative(
      ffi.Pointer<WGPUComputePipelineDescriptor> ptr)
      : super._adopt(ptr);
  ComputePipelineDescriptor._copy(
      ffi.Pointer<WGPUComputePipelineDescriptor> ptr)
      : super._copy(ptr);

  ComputePipelineDescriptor copy() => ComputePipelineDescriptor._copy(_ptr);

  WGPUComputePipelineDescriptor get _ref => _ptr.ref;

  int get layout => _ref.layout;

  ProgrammableStageDescriptor get computeStage =>
      ProgrammableStageDescriptor.fromNative(_ref.compute_stage.addressOf);
}

class PipelineLayoutDescriptor extends _WGPUType<WGPUPipelineLayoutDescriptor> {
  PipelineLayoutDescriptor() : super._alloc();
  PipelineLayoutDescriptor.fromNative(
      ffi.Pointer<WGPUPipelineLayoutDescriptor> ptr)
      : super._adopt(ptr);
  PipelineLayoutDescriptor._copy(ffi.Pointer<WGPUPipelineLayoutDescriptor> ptr)
      : super._copy(ptr);

  PipelineLayoutDescriptor copy() => PipelineLayoutDescriptor._copy(_ptr);

  WGPUPipelineLayoutDescriptor get _ref => _ptr.ref;

  List<int> get bindGroupLayouts => _ref.bind_group_layouts
      .asTypedList(_ref.bind_group_layouts_length)
      .toList();
}

class RenderBundleEncoderDescriptor
    extends _WGPUType<WGPURenderBundleEncoderDescriptor> {
  RenderBundleEncoderDescriptor() : super._alloc();
  RenderBundleEncoderDescriptor.fromNative(
      ffi.Pointer<WGPURenderBundleEncoderDescriptor> ptr)
      : super._adopt(ptr);
  RenderBundleEncoderDescriptor._copy(
      ffi.Pointer<WGPURenderBundleEncoderDescriptor> ptr)
      : super._copy(ptr);

  RenderBundleEncoderDescriptor copy() =>
      RenderBundleEncoderDescriptor._copy(_ptr);

  WGPURenderBundleEncoderDescriptor get _ref => _ptr.ref;

  String get label => ffi.Utf8.fromUtf8(_ref.label.cast());

  List<TextureFormat> get colorFormats {
    // ### TODO: lazy iterable
    var formats = <TextureFormat>[];
    for (var i = 0; i < _ref.color_formats_length; ++i) {
      formats.add(TextureFormat.values[_ref.color_formats[i]]);
    }
    return formats;
  }

  List<TextureFormat> get depthStencilFormats {
    // ### TODO: lazy iterable
    var formats = <TextureFormat>[];
    for (var i = 0; i < _ref.color_formats_length; ++i) {
      formats.add(TextureFormat.values[_ref.depth_stencil_format[i]]);
    }
    return formats;
  }

  int get sampleCount => _ref.sample_count;
}

/// Describes the state of the rasterizer in a render pipeline.
class RasterizationStateDescriptor
    extends _WGPUType<WGPURasterizationStateDescriptor> {
  RasterizationStateDescriptor() : super._alloc();
  RasterizationStateDescriptor.fromNative(
      ffi.Pointer<WGPURasterizationStateDescriptor> ptr)
      : super._adopt(ptr);
  RasterizationStateDescriptor._copy(
      ffi.Pointer<WGPURasterizationStateDescriptor> ptr)
      : super._copy(ptr);

  RasterizationStateDescriptor copy() =>
      RasterizationStateDescriptor._copy(_ptr);

  WGPURasterizationStateDescriptor get _ref => _ptr.ref;

  FrontFace get frontFace => FrontFace.values[_ref.front_face];
  CullMode get cullMode => CullMode.values[_ref.cull_mode];
  int get depthBias => _ref.depth_bias;
  double get depthBiasSlopeScale => _ref.depth_bias_slope_scale;
  double get depthBiasClamp => _ref.depth_bias_clamp;
}

/// Describes the blend state of a pipeline.
///
/// Alpha blending is very complicated: see the OpenGL or Vulkan spec for more information.
class BlendDescriptor extends _WGPUType<WGPUBlendDescriptor> {
  BlendDescriptor() : super._alloc();
  BlendDescriptor.fromNative(ffi.Pointer<WGPUBlendDescriptor> ptr)
      : super._adopt(ptr);
  BlendDescriptor._copy(ffi.Pointer<WGPUBlendDescriptor> ptr)
      : super._copy(ptr);

  BlendDescriptor copy() => BlendDescriptor._copy(_ptr);

  WGPUBlendDescriptor get _ref => _ptr.ref;

  BlendFactor get srcFactor => BlendFactor.values[_ref.src_factor];
  BlendFactor get dstFactor => BlendFactor.values[_ref.dst_factor];
  BlendOperation get operation => BlendOperation.values[_ref.operation];
}

/// Describes the color state of a render pipeline.
class ColorStateDescriptor extends _WGPUType<WGPUColorStateDescriptor> {
  ColorStateDescriptor() : super._alloc();
  ColorStateDescriptor.fromNative(ffi.Pointer<WGPUColorStateDescriptor> ptr)
      : super._adopt(ptr);
  ColorStateDescriptor._copy(ffi.Pointer<WGPUColorStateDescriptor> ptr)
      : super._copy(ptr);

  ColorStateDescriptor copy() => ColorStateDescriptor._copy(_ptr);

  WGPUColorStateDescriptor get _ref => _ptr.ref;

  /// The [`TextureFormat`] of the image that this pipeline will render to. Must match the the format
  /// of the corresponding color attachment in [`CommandEncoder::begin_render_pass`].
  TextureFormat get format => TextureFormat.values[_ref.format];

  /// The alpha blending that is used for this pipeline.
  BlendDescriptor get alphaBlend =>
      BlendDescriptor.fromNative(_ref.alpha_blend.addressOf);

  /// The color blending that is used for this pipeline.
  BlendDescriptor get colorBlend =>
      BlendDescriptor.fromNative(_ref.color_blend.addressOf);

  /// Mask which enables/disables writes to different color/alpha channel.
  int get writeMask => _ref.write_mask;
}

/// Describes stencil state in a render pipeline.
///
/// If you are not using stencil state, set this to [`StencilStateFaceDescriptor::IGNORE`].
class StencilStateFaceDescriptor
    extends _WGPUType<WGPUStencilStateFaceDescriptor> {
  StencilStateFaceDescriptor() : super._alloc();
  StencilStateFaceDescriptor.fromNative(
      ffi.Pointer<WGPUStencilStateFaceDescriptor> ptr)
      : super._adopt(ptr);
  StencilStateFaceDescriptor._copy(
      ffi.Pointer<WGPUStencilStateFaceDescriptor> ptr)
      : super._copy(ptr);

  StencilStateFaceDescriptor copy() => StencilStateFaceDescriptor._copy(_ptr);

  WGPUStencilStateFaceDescriptor get _ref => _ptr.ref;

  /// Comparison function that determines if the fail_op or pass_op is used on the stencil buffer.
  CompareFunction get compare => CompareFunction.values[_ref.compare];

  /// Operation that is preformed when stencil test fails.
  StencilOperation get failOp => StencilOperation.values[_ref.fail_op];

  /// Operation that is performed when depth test fails but stencil test succeeds.
  StencilOperation get depthFailOp =>
      StencilOperation.values[_ref.depth_fail_op];

  /// Operation that is performed when stencil test success.
  StencilOperation get passOp => StencilOperation.values[_ref.pass_op];
}

/// Describes the depth/stencil state in a render pipeline.
class DepthStencilStateDescriptor
    extends _WGPUType<WGPUDepthStencilStateDescriptor> {
  DepthStencilStateDescriptor() : super._alloc();
  DepthStencilStateDescriptor.fromNative(
      ffi.Pointer<WGPUDepthStencilStateDescriptor> ptr)
      : super._adopt(ptr);
  DepthStencilStateDescriptor._copy(
      ffi.Pointer<WGPUDepthStencilStateDescriptor> ptr)
      : super._copy(ptr);

  DepthStencilStateDescriptor copy() => DepthStencilStateDescriptor._copy(_ptr);

  WGPUDepthStencilStateDescriptor get _ref => _ptr.ref;

  /// Format of the depth/stencil buffer, must be special depth format. Must match the the format
  /// of the depth/stencil attachment in [`CommandEncoder::begin_render_pass`].
  TextureFormat get format => TextureFormat.values[_ref.format];

  /// If disabled, depth will not be written to.
  bool get depthWriteEnabled => _ref.depth_write_enabled != 0;

  /// Comparison function used to compare depth values in the depth test.
  CompareFunction get depthCompare =>
      CompareFunction.values[_ref.depth_compare];

  /// Stencil state used for front faces.
  StencilStateFaceDescriptor get stencilFormat =>
      StencilStateFaceDescriptor.fromNative(_ref.stencil_front.addressOf);

  /// Stencil state used for back faces.
  StencilStateFaceDescriptor get stencilBack =>
      StencilStateFaceDescriptor.fromNative(_ref.stencil_back.addressOf);

  /// Stencil values are AND'd with this mask when reading and writing from the stencil buffer. Only low 8 bits are used.
  StencilOperation get stencilReadMask =>
      StencilOperation.values[_ref.stencil_read_mask];

  /// Stencil values are AND'd with this mask when writing to the stencil buffer. Only low 8 bits are used.
  StencilOperation get stencilWriteMask =>
      StencilOperation.values[_ref.stencil_write_mask];
}

/// Vertex inputs (attributes) to shaders.
///
/// Arrays of these can be made with the [`vertex_attr_array`] macro. Vertex attributes are assumed to be tightly packed.
class VertexAttributeDescriptor
    extends _WGPUType<WGPUVertexAttributeDescriptor> {
  VertexAttributeDescriptor() : super._alloc();
  VertexAttributeDescriptor.fromNative(
      ffi.Pointer<WGPUVertexAttributeDescriptor> ptr)
      : super._adopt(ptr);
  VertexAttributeDescriptor._copy(
      ffi.Pointer<WGPUVertexAttributeDescriptor> ptr)
      : super._copy(ptr);

  VertexAttributeDescriptor copy() => VertexAttributeDescriptor._copy(_ptr);

  WGPUVertexAttributeDescriptor get _ref => _ptr.ref;

  /// Byte offset of the start of the input
  int get offset => _ref.offset;

  /// Format of the input
  VertexFormat get format => VertexFormat.values[_ref.format];

  /// Location for this input. Must match the location in the shader.
  int get shaderLocation => _ref.shader_location;
}

class VertexBufferLayoutDescriptor
    extends _WGPUType<WGPUVertexBufferLayoutDescriptor> {
  VertexBufferLayoutDescriptor() : super._alloc();
  VertexBufferLayoutDescriptor.fromNative(
      ffi.Pointer<WGPUVertexBufferLayoutDescriptor> ptr)
      : super._adopt(ptr);
  VertexBufferLayoutDescriptor._copy(
      ffi.Pointer<WGPUVertexBufferLayoutDescriptor> ptr)
      : super._copy(ptr);

  VertexBufferLayoutDescriptor copy() =>
      VertexBufferLayoutDescriptor._copy(_ptr);

  WGPUVertexBufferLayoutDescriptor get _ref => _ptr.ref;

  int get arrayStride => _ref.array_stride;
  InputStepMode get stepMode => InputStepMode.values[_ref.step_mode];

  List<VertexAttributeDescriptor> get attributes {
    // ### TODO: lazy iterable
    var attrs = <VertexAttributeDescriptor>[];
    for (var i = 0; i < _ref.attributes_length; ++i) {
      attrs.add(
          VertexAttributeDescriptor.fromNative(_ref.attributes.elementAt(i)));
    }
    return attrs;
  }
}

class VertexStateDescriptor extends _WGPUType<WGPUVertexStateDescriptor> {
  VertexStateDescriptor() : super._alloc();
  VertexStateDescriptor.fromNative(ffi.Pointer<WGPUVertexStateDescriptor> ptr)
      : super._adopt(ptr);
  VertexStateDescriptor._copy(ffi.Pointer<WGPUVertexStateDescriptor> ptr)
      : super._copy(ptr);

  VertexStateDescriptor copy() => VertexStateDescriptor._copy(_ptr);

  WGPUVertexStateDescriptor get _ref => _ptr.ref;

  IndexFormat get indexFormat => IndexFormat.values[_ref.index_format];

  List<VertexBufferLayoutDescriptor> get vertexBuffers {
    // ### TODO: lazy iterable
    var buffers = <VertexBufferLayoutDescriptor>[];
    for (var i = 0; i < _ref.vertex_buffers_length; ++i) {
      buffers.add(VertexBufferLayoutDescriptor.fromNative(
          _ref.vertex_buffers.elementAt(i)));
    }
    return buffers;
  }
}

class RenderPipelineDescriptor extends _WGPUType<WGPURenderPipelineDescriptor> {
  RenderPipelineDescriptor() : super._alloc();
  RenderPipelineDescriptor.fromNative(
      ffi.Pointer<WGPURenderPipelineDescriptor> ptr)
      : super._adopt(ptr);
  RenderPipelineDescriptor._copy(ffi.Pointer<WGPURenderPipelineDescriptor> ptr)
      : super._copy(ptr);

  RenderPipelineDescriptor copy() => RenderPipelineDescriptor._copy(_ptr);

  WGPURenderPipelineDescriptor get _ref => _ptr.ref;

  int get layout => _ref.layout;

  ProgrammableStageDescriptor get vertexStage =>
      ProgrammableStageDescriptor.fromNative(_ref.vertex_stage.addressOf);

  ProgrammableStageDescriptor get fragmentStage =>
      ProgrammableStageDescriptor.fromNative(_ref.fragment_stage);

  PrimitiveTopology get primitiveTopology =>
      PrimitiveTopology.values[_ref.primitive_topology];

  RasterizationStateDescriptor get rasterizationState =>
      RasterizationStateDescriptor.fromNative(_ref.rasterization_state);

  List<ColorStateDescriptor> get colorStates {
    // ### TODO: lazy iterable
    var states = <ColorStateDescriptor>[];
    for (var i = 0; i < _ref.color_states_length; ++i) {
      states
          .add(ColorStateDescriptor.fromNative(_ref.color_states.elementAt(i)));
    }
    return states;
  }

  DepthStencilStateDescriptor get depthStencilState =>
      DepthStencilStateDescriptor.fromNative(_ref.depth_stencil_state);

  VertexStateDescriptor get vertexState =>
      VertexStateDescriptor.fromNative(_ref.vertex_state.addressOf);

  int get sampleCount => _ref.sample_count;
  int get sampleMask => _ref.sample_mask;
  bool get alphaToCoverageEnabled => _ref.alpha_to_coverage_enabled != 0;
}

class SamplerDescriptor extends _WGPUType<WGPUSamplerDescriptor> {
  SamplerDescriptor() : super._alloc();
  SamplerDescriptor.fromNative(ffi.Pointer<WGPUSamplerDescriptor> ptr)
      : super._adopt(ptr);
  SamplerDescriptor._copy(ffi.Pointer<WGPUSamplerDescriptor> ptr)
      : super._copy(ptr);

  SamplerDescriptor copy() => SamplerDescriptor._copy(_ptr);

  WGPUSamplerDescriptor get _ref => _ptr.ref;

  ChainedStruct get nextInChain =>
      ChainedStruct.fromNative(_ref.next_in_chain.cast());

  String get label => ffi.Utf8.fromUtf8(_ref.label.cast());

  AddressMode get addressModeU => AddressMode.values[_ref.address_mode_u];

  AddressMode get addressModeV => AddressMode.values[_ref.address_mode_v];

  AddressMode get addressModeW => AddressMode.values[_ref.address_mode_w];

  FilterMode get magFilter => FilterMode.values[_ref.mag_filter];

  FilterMode get minFilter => FilterMode.values[_ref.min_filter];

  FilterMode get mipmapFilter => FilterMode.values[_ref.mipmap_filter];

  double get lodMinClamp => _ref.lod_min_clamp;

  double get lodMaxClamp => _ref.lod_max_clamp;

  CompareFunction get compare => CompareFunction.values[_ref.compare];
}

class ShaderSource extends _WGPUType<WGPUShaderSource> {
  ShaderSource() : super._alloc();
  ShaderSource.fromNative(ffi.Pointer<WGPUShaderSource> ptr)
      : super._adopt(ptr);
  ShaderSource._copy(ffi.Pointer<WGPUShaderSource> ptr) : super._copy(ptr);

  ShaderSource copy() => ShaderSource._copy(_ptr);

  WGPUShaderSource get _ref => _ptr.ref;

  UnmodifiableUint32ListView get bytes {
    return UnmodifiableUint32ListView(_ref.bytes.asTypedList(_ref.length));
  }
}

/// Describes a [`SwapChain`].
class SwapChainDescriptor extends _WGPUType<WGPUSwapChainDescriptor> {
  SwapChainDescriptor() : super._alloc();
  SwapChainDescriptor.fromNative(ffi.Pointer<WGPUSwapChainDescriptor> ptr)
      : super._adopt(ptr);
  SwapChainDescriptor._copy(ffi.Pointer<WGPUSwapChainDescriptor> ptr)
      : super._copy(ptr);

  SwapChainDescriptor copy() => SwapChainDescriptor._copy(_ptr);

  WGPUSwapChainDescriptor get _ref => _ptr.ref;

  /// The usage of the swap chain. The only supported usage is OUTPUT_ATTACHMENT
  int get usage => _ref.usage;

  /// The texture format of the swap chain. The only formats that are guaranteed are
  /// `Bgra8Unorm` and `Bgra8UnormSrgb`
  TextureFormat get format => TextureFormat.values[_ref.format];

  /// Width of the swap chain. Must be the same size as the surface.
  int get width => _ref.width;

  /// Height of the swap chain. Must be the same size as the surface.
  int get height => _ref.height;

  /// Presentation mode of the swap chain. FIFO is the only guaranteed to be supported, though
  /// other formats will automatically fall back to FIFO.
  PresentMode get presentMode => PresentMode.values[_ref.present_mode];
}

/// Describes a [`Texture`].
class TextureDescriptor extends _WGPUType<WGPUTextureDescriptor> {
  TextureDescriptor() : super._alloc();
  TextureDescriptor.fromNative(ffi.Pointer<WGPUTextureDescriptor> ptr)
      : super._adopt(ptr);
  TextureDescriptor._copy(ffi.Pointer<WGPUTextureDescriptor> ptr)
      : super._copy(ptr);

  TextureDescriptor copy() => TextureDescriptor._copy(_ptr);

  WGPUTextureDescriptor get _ref => _ptr.ref;

  /// Debug label of the texture. This will show up in graphics debuggers for easy identification.
  String get label => ffi.Utf8.fromUtf8(_ref.label.cast());

  /// Size of the texture. For a regular 1D/2D texture, the unused sizes will be 1. For 2DArray textures, Z is the
  /// number of 2D textures in that array.
  Extent3D get size => Extent3D.fromNative(_ref.size.addressOf);

  /// Mip count of texture. For a texture with no extra mips, this must be 1.
  int get mipLevelCount => _ref.mip_level_count;

  /// Sample count of texture. If this is not 1, texture must have [`BindingType::SampledTexture::multisampled`] set to true.
  int get sampleCount => _ref.sample_count;

  /// Dimensions of the texture.
  TextureDimension get dimension => TextureDimension.values[_ref.dimension];

  /// Format of the texture.
  TextureFormat get format => TextureFormat.values[_ref.format];

  /// Allowed usages of the texture. If used in other ways, the operation will panic.
  int get usage => _ref.usage;
}

/// Describes a [`RenderBundle`].
class RenderBundleDescriptor_Label
    extends _WGPUType<WGPURenderBundleDescriptor_Label> {
  RenderBundleDescriptor_Label() : super._alloc();
  RenderBundleDescriptor_Label.fromNative(
      ffi.Pointer<WGPURenderBundleDescriptor_Label> ptr)
      : super._adopt(ptr);
  RenderBundleDescriptor_Label._copy(
      ffi.Pointer<WGPURenderBundleDescriptor_Label> ptr)
      : super._copy(ptr);

  RenderBundleDescriptor_Label copy() =>
      RenderBundleDescriptor_Label._copy(_ptr);

  WGPURenderBundleDescriptor_Label get _ref => _ptr.ref;

  /// Debug label of the render bundle encoder. This will show up in graphics debuggers for easy identification.
  String get label => ffi.Utf8.fromUtf8(_ref.label.cast());
}

class RequestAdapterOptions extends _WGPUType<WGPURequestAdapterOptions> {
  RequestAdapterOptions() : super._alloc();
  RequestAdapterOptions.fromNative(ffi.Pointer<WGPURequestAdapterOptions> ptr)
      : super._adopt(ptr);
  RequestAdapterOptions._copy(ffi.Pointer<WGPURequestAdapterOptions> ptr)
      : super._copy(ptr);

  RequestAdapterOptions copy() => RequestAdapterOptions._copy(_ptr);

  WGPURequestAdapterOptions get _ref => _ptr.ref;

  PowerPreference get powerPreference =>
      PowerPreference.values[_ref.power_preference];

  int get compatibleSurface => _ref.compatible_surface;
}

class SwapChainOutput extends _WGPUType<WGPUSwapChainOutput> {
  SwapChainOutput() : super._alloc();
  SwapChainOutput.fromNative(ffi.Pointer<WGPUSwapChainOutput> ptr)
      : super._adopt(ptr);
  SwapChainOutput._copy(ffi.Pointer<WGPUSwapChainOutput> ptr)
      : super._copy(ptr);

  SwapChainOutput copy() => SwapChainOutput._copy(_ptr);

  WGPUSwapChainOutput get _ref => _ptr.ref;

  SwapChainStatus get status => SwapChainStatus.values[_ref.status];

  int get viewId => _ref.view_id;
}

/// Describes a [`TextureView`].
class TextureViewDescriptor extends _WGPUType<WGPUTextureViewDescriptor> {
  TextureViewDescriptor() : super._alloc();
  TextureViewDescriptor.fromNative(ffi.Pointer<WGPUTextureViewDescriptor> ptr)
      : super._adopt(ptr);
  TextureViewDescriptor._copy(ffi.Pointer<WGPUTextureViewDescriptor> ptr)
      : super._copy(ptr);

  TextureViewDescriptor copy() => TextureViewDescriptor._copy(_ptr);

  WGPUTextureViewDescriptor get _ref => _ptr.ref;

  /// Debug label of the texture view. This will show up in graphics debuggers for easy identification.
  String get label => ffi.Utf8.fromUtf8(_ref.label.cast());

  /// Format of the texture view. At this time, it must be the same as the underlying format of the texture.
  TextureFormat get format => TextureFormat.values[_ref.format];

  /// The dimension of the texture view. For 1D textures, this must be `1D`. For 2D textures it must be one of
  /// `D2`, `D2Array`, `Cube`, and `CubeArray`. For 3D textures it must be `3D`
  TextureDimension get dimension => TextureDimension.values[_ref.dimension];

  /// Aspect of the texture. Color textures must be [`TextureAspect::All`].
  TextureAspect get aspect => TextureAspect.values[_ref.aspect];

  /// Base mip level.
  int get baseMipLevel => _ref.base_mip_level;

  /// Mip level count. Must be at least one. base_mip_level + level_count must be less or equal to underlying texture mip count.
  int get levelCount => _ref.level_count;

  /// Base array layer.
  int get baseArrayLayer => _ref.base_array_layer;

  /// Layer count. Must be at least one. base_array_layer + array_layer_count must be less or equal to the underlying array count.
  int get arrayLayerCount => _ref.array_layer_count;
}

class AnisotropicSamplerDescriptorExt
    extends _WGPUType<WGPUAnisotropicSamplerDescriptorExt> {
  AnisotropicSamplerDescriptorExt() : super._alloc();
  AnisotropicSamplerDescriptorExt.fromNative(
      ffi.Pointer<WGPUAnisotropicSamplerDescriptorExt> ptr)
      : super._adopt(ptr);
  AnisotropicSamplerDescriptorExt._copy(
      ffi.Pointer<WGPUAnisotropicSamplerDescriptorExt> ptr)
      : super._copy(ptr);

  AnisotropicSamplerDescriptorExt copy() =>
      AnisotropicSamplerDescriptorExt._copy(_ptr);

  WGPUAnisotropicSamplerDescriptorExt get _ref => _ptr.ref;

  ChainedStruct get nextInChain =>
      ChainedStruct.fromNative(_ref.next_in_chain.cast());

  SType get sType => SType.values[_ref.s_type];

  int get anisotropicClamp => _ref.anisotropic_clamp;
}

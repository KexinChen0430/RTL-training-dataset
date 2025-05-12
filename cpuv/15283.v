module SpriteRegDecoder(reg_values,
                        enabled,
                        enable_scroll,
                        enable_transp,
                        enable_alpha,
                        enable_color,
                        flip_x,
                        flip_y,
                        flip_xy,
                        shift_data_offset,
                        palette,
                        width,
                        height,
                        ctrl0,
                        ctrl1,
                        data_offset,
                        ref_xy,
                        color_key,
                        offset_x,
                        offset_y);
  input [`NUM_REG_BITS_PER_SPRITE-1:0] reg_values;
  output enabled;
  output enable_scroll;
  output enable_transp;
  output enable_alpha;
  output enable_color;
  output flip_x;
  output flip_y;
  output flip_xy;
  output shift_data_offset;
  output [`SPRITE_PALETTE_WIDTH-1:0] palette;
  output [31:0] width;
  output [31:0] height;
  output [`REG_DATA_WIDTH-1:0] ctrl0;
  output [`REG_DATA_WIDTH-1:0] ctrl1;
  output [`VRAM_ADDR_WIDTH:0] data_offset;
  output [`REG_DATA_WIDTH-1:0] ref_xy;
  output [`REG_DATA_WIDTH-1:0] color_key;
  output [`REG_DATA_WIDTH-1:0] offset_x;
  output [`REG_DATA_WIDTH-1:0] offset_y;
  wire [`REG_DATA_WIDTH-1:0] regs [`NUM_SPRITE_REGS-1:0];
  genvar i;
  generate
    for (i = 0; i < `NUM_SPRITE_REGS; i = i + 1) begin: SPRITE_REGS
      assign regs[i] = reg_values[(i+1)*`REG_DATA_WIDTH-1:i*`REG_DATA_WIDTH];
    end
  endgenerate
  assign enabled            = ctrl0[`SPRITE_ENABLED];
  assign enable_scroll      = ctrl0[`SPRITE_ENABLE_SCROLL];
  assign enable_transp      = ctrl0[`SPRITE_ENABLE_TRANSP];
  assign enable_alpha       = ctrl0[`SPRITE_ENABLE_ALPHA];
  assign enable_color       = ctrl0[`SPRITE_ENABLE_COLOR];
  assign flip_x             = ctrl0[`SPRITE_FLIP_X];
  assign flip_y             = ctrl0[`SPRITE_FLIP_Y];
  assign flip_xy            = ctrl0[`SPRITE_FLIP_XY];
  assign shift_data_offset  = ctrl0[`SPRITE_SHIFT_DATA_OFFSET];
  assign palette            = ctrl0[`SPRITE_PALETTE_END:`SPRITE_PALETTE_START];
  wire [1:0] width_shift  = ctrl1[`SPRITE_HSIZE_END:`SPRITE_HSIZE_START];
  wire [1:0] height_shift = ctrl1[`SPRITE_VSIZE_END:`SPRITE_VSIZE_START];
  assign width         = (`SPRITE_MIN_SIZE << width_shift);
  assign height        = (`SPRITE_MIN_SIZE << height_shift);
  assign ctrl0         = regs[`SPRITE_CTRL0];
  assign ctrl1         = regs[`SPRITE_CTRL1];
  assign data_offset   =
      shift_data_offset
          ? (regs[`SPRITE_DATA_OFFSET] << `SPRITE_DATA_OFFSET_SHIFT)
          : regs[`SPRITE_DATA_OFFSET];
  assign ref_xy        = regs[`SPRITE_REF_XY];
  assign color_key     = regs[`SPRITE_COLOR_KEY];
  assign offset_x      = regs[`SPRITE_OFFSET_X];
  assign offset_y      = regs[`SPRITE_OFFSET_Y];
endmodule
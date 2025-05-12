
module axis_srl_fifo  #(parameter 
       DATA_WIDTH  = 8,
       KEEP_ENABLE = DATA_WIDTH > 8,
       KEEP_WIDTH  = DATA_WIDTH/8,
       LAST_ENABLE = 1,
       ID_ENABLE   = 0,
       ID_WIDTH    = 8,
       DEST_ENABLE = 0,
       DEST_WIDTH  = 8,
       USER_ENABLE = 1,
       USER_WIDTH  = 1,
       DEPTH       = 16)
  (input  wire clk,
   input  wire rst,
   input  wire [DATA_WIDTH+(0-1):0] s_axis_tdata,
   input  wire [(0-1)+KEEP_WIDTH:0] s_axis_tkeep,
   input  wire s_axis_tvalid,
   output wire s_axis_tready,
   input  wire s_axis_tlast,
   input  wire [ID_WIDTH+(0-1):0] s_axis_tid,
   input  wire [(0-1)+DEST_WIDTH:0] s_axis_tdest,
   input  wire [(0-1)+USER_WIDTH:0] s_axis_tuser,
   output wire [DATA_WIDTH+(0-1):0] m_axis_tdata,
   output wire [(0-1)+KEEP_WIDTH:0] m_axis_tkeep,
   output wire m_axis_tvalid,
   input  wire m_axis_tready,
   output wire m_axis_tlast,
   output wire [ID_WIDTH+(0-1):0] m_axis_tid,
   output wire [(0-1)+DEST_WIDTH:0] m_axis_tdest,
   output wire [(0-1)+USER_WIDTH:0] m_axis_tuser,
   output wire [$clog2(1+DEPTH)+(0-1):0] count);

  localparam  KEEP_OFFSET = DATA_WIDTH;
  localparam 
       LAST_OFFSET = (KEEP_ENABLE ? KEEP_WIDTH : 0)+KEEP_OFFSET;
  localparam  ID_OFFSET = LAST_OFFSET+(LAST_ENABLE ? 1 : 0);
  localparam 
       DEST_OFFSET = ID_OFFSET+(ID_ENABLE ? ID_WIDTH : 0);
  localparam 
       USER_OFFSET = (DEST_ENABLE ? DEST_WIDTH : 0)+DEST_OFFSET;
  localparam 
       WIDTH = (USER_ENABLE ? USER_WIDTH : 0)+USER_OFFSET;
  reg  [WIDTH-1:0] data_reg[DEPTH-1:0];
  reg  [$clog2(1+DEPTH)+(0-1):0]  ptr_reg = 0;
  reg   full_reg = 1'b0,full_next;
  reg   empty_reg = 1'b1,empty_next;
  wire [WIDTH-1:0] s_axis;
  wire [WIDTH-1:0]  m_axis = data_reg[ptr_reg+(0-1)];

  assign s_axis_tready = !full_reg;
  
  generate
      assign s_axis[DATA_WIDTH+(0-1):0] = s_axis_tdata;
      if (KEEP_ENABLE) assign s_axis[KEEP_OFFSET +: KEEP_WIDTH] = s_axis_tkeep;
        
      if (LAST_ENABLE) assign s_axis[LAST_OFFSET] = s_axis_tlast;
        
      if (ID_ENABLE) assign s_axis[ID_OFFSET +: ID_WIDTH] = s_axis_tid;
        
      if (DEST_ENABLE) assign s_axis[DEST_OFFSET +: DEST_WIDTH] = s_axis_tdest;
        
      if (USER_ENABLE) assign s_axis[USER_OFFSET +: USER_WIDTH] = s_axis_tuser;
        
  endgenerate

  assign m_axis_tvalid = !empty_reg;
  assign m_axis_tdata = m_axis[DATA_WIDTH+(0-1):0];
  assign m_axis_tkeep = KEEP_ENABLE ? m_axis[KEEP_OFFSET +: KEEP_WIDTH] : {KEEP_WIDTH{1'b1}};
  assign m_axis_tlast = LAST_ENABLE ? m_axis[LAST_OFFSET] : 1'b1;
  assign m_axis_tid = ID_ENABLE ? m_axis[ID_OFFSET +: ID_WIDTH] : {ID_WIDTH{1'b0}};
  assign m_axis_tdest = DEST_ENABLE ? m_axis[DEST_OFFSET +: DEST_WIDTH] : {DEST_WIDTH{1'b0}};
  assign m_axis_tuser = USER_ENABLE ? m_axis[USER_OFFSET +: USER_WIDTH] : {USER_WIDTH{1'b0}};
  assign count = ptr_reg;
  wire  ptr_empty = ptr_reg == 0;

  wire  ptr_empty1 = ptr_reg == 1;

  wire  ptr_full = ptr_reg == DEPTH;

  wire  ptr_full1 = ptr_reg == (DEPTH-1);

  reg  shift;

  reg  inc;

  reg  dec;

  integer i;

  
  initial  
  begin
    for (i = 0; i < DEPTH; i = i+1)
        begin
          data_reg[i] <= 0;
        end
  end
  
  always @* 
      begin
        shift = 1'b0;
        inc = 1'b0;
        dec = 1'b0;
        full_next = full_reg;
        empty_next = empty_reg;
        if (s_axis_tready && s_axis_tvalid && m_axis_tready) 
          begin
            shift = 1'b1;
            inc = ptr_empty;
            empty_next = 1'b0;
          end
        else if (m_axis_tvalid && m_axis_tready) 
          begin
            dec = 1'b1;
            full_next = 1'b0;
            empty_next = ptr_empty1;
          end
        else if (s_axis_tready && s_axis_tvalid) 
          begin
            shift = 1'b1;
            inc = 1'b1;
            full_next = ptr_full1;
            empty_next = 1'b0;
          end
          
      end
  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            ptr_reg <= 0;
            full_reg <= 1'b0;
            empty_reg <= 1'b1;
          end
        else 
          begin
            if (inc) 
              begin
                ptr_reg <= ptr_reg+1;
              end
            else if (dec) 
              begin
                ptr_reg <= ptr_reg+(0-1);
              end
            else 
              begin
                ptr_reg <= ptr_reg;
              end
            full_reg <= full_next;
            empty_reg <= empty_next;
          end
        if (shift) 
          begin
            data_reg[0] <= s_axis;
            for (i = 0; i < (DEPTH-1); i = i+1)
                begin
                  data_reg[i+1] <= data_reg[i];
                end
          end
          
      end
endmodule


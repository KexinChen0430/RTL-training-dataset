module zet_wb_master (
    input clk,                
    input rst,                
    input      [19:0] umif_adr_i, 
    output reg [15:0] umif_dat_o, 
    input             umif_stb_i, 
    input             umif_by_i,  
    output reg        umif_ack_o, 
    input      [19:0] umie_adr_i, 
    output reg [15:0] umie_dat_o, 
    input      [15:0] umie_dat_i, 
    input             umie_we_i,  
    input             umie_by_i,  
    input             umie_stb_i, 
    output reg        umie_ack_o, 
    input             umie_tga_i, 
    input      [15:0] wb_dat_i,   
    output reg [15:0] wb_dat_o,   
    output reg [19:1] wb_adr_o,   
    output reg        wb_we_o,    
    output reg        wb_tga_o,   
    output reg [ 1:0] wb_sel_o,   
    output reg        wb_stb_o,   
    output reg        wb_cyc_o,   
    input             wb_ack_i    
);
wire [15:0] blw;   
wire [15:0] bhw;   
reg  [ 2:0] cs;    
reg  [ 2:0] ns;    
localparam [2:0]
    IDLE = 3'd0, 
    BY1E = 3'd1, 
    BY2E = 3'd2, 
    ACKE = 3'd3, 
    BY1F = 3'd4, 
    BY2F = 3'd5, 
    ACKF = 3'd6; 
assign blw = { {8{wb_dat_i[ 7]}}, wb_dat_i[ 7:0] }; 
assign bhw = { {8{wb_dat_i[15]}}, wb_dat_i[15:8] }; 
always @(posedge clk) cs <= rst ? IDLE : ns; 
always @(posedge clk)
    umie_ack_o <= rst ? 1'b0 
      : (((cs==BY1E && (umie_by_i || !umie_by_i && !umie_adr_i[0])) 
      || cs==BY2E) & wb_ack_i); 
always @(posedge clk)
    umif_ack_o <= rst ? 1'b0 
      : (((cs==BY1F && (umif_by_i || !umif_by_i && !umif_adr_i[0])) 
      || cs==BY2F) & wb_ack_i); 
always @(posedge clk)
    if (rst)
      wb_adr_o <= 19'h0; 
    else
      case (ns) 
        BY1E: wb_adr_o <= umie_adr_i[19:1]; 
        BY2E: wb_adr_o <= umie_adr_i[19:1] + 19'd1; 
        BY1F: wb_adr_o <= umif_adr_i[19:1]; 
        BY2F: wb_adr_o <= umif_adr_i[19:1] + 19'd1; 
        default: wb_adr_o <= 19'h0; 
      endcase
always @(posedge clk)
    wb_we_o <= rst ? 1'b0 : (ns==BY1E || ns==BY2E) & umie_we_i; 
always @(posedge clk)
    wb_tga_o <= rst ? 1'b0 : (ns==BY1E || ns==BY2E) & umie_tga_i; 
always @(posedge clk)
    wb_stb_o <= rst ? 1'b0 : (ns==BY1E || ns==BY2E || ns==BY1F || ns==BY2F); 
always @(posedge clk)
    wb_cyc_o <= rst ? 1'b0 : (ns==BY1E || ns==BY2E || ns==BY1F || ns==BY2F); 
always @(posedge clk)
    if (rst)
      wb_sel_o <= 2'b00; 
    else
      case (ns) 
        BY1E: wb_sel_o <= umie_adr_i[0] ? 2'b10 
                        : (umie_by_i ? 2'b01 : 2'b11); 
        BY2E: wb_sel_o <= 2'b01; 
        default: wb_sel_o <= 2'b11; 
      endcase
always @(posedge clk)
    wb_dat_o <= rst ? 16'h0 
      : (ns==BY1E || ns==BY2E) ? 
        (umie_adr_i[0] ? 
          { umie_dat_i[7:0], umie_dat_i[15:8] } : umie_dat_i) 
          : wb_dat_o; 
always @(posedge clk)
    umif_dat_o <= rst ? 16'h0 
      : (cs==BY1F && wb_ack_i) ? (umif_adr_i[0] ? bhw 
         : (umif_by_i ? blw : wb_dat_i)) 
      : (cs==BY2F && wb_ack_i) ? {wb_dat_i[7:0], umif_dat_o[7:0]} 
      : umif_dat_o; 
always @(posedge clk)
    umie_dat_o <= rst ? 16'h0 
      : (cs==BY1E && wb_ack_i) ? (umie_adr_i[0] ? bhw 
         : (umie_by_i ? blw : wb_dat_i)) 
      : (cs==BY2E && wb_ack_i) ? {wb_dat_i[7:0], umie_dat_o[7:0]} 
      : umie_dat_o; 
always @(*)
    case (cs) 
      default:  
        if (umie_stb_i) ns = BY1E; 
        else if (umif_stb_i) ns = BY1F; 
        else ns = IDLE; 
      BY1E:     
        if (wb_ack_i) 
          begin
            if (umie_adr_i[0] && !umie_by_i) ns = BY2E; 
            else
              begin
                if (umif_stb_i && !umif_ack_o) ns = BY1F; 
                else ns = ACKE; 
              end
          end
        else ns = BY1E; 
      BY2E:     
        if (wb_ack_i) 
          if (umif_stb_i) ns = BY1F; 
          else ns = ACKE; 
        else ns = BY2E; 
      ACKE:     
        if (umif_stb_i) ns = BY1F; 
        else ns = IDLE; 
      BY1F:     
        if (wb_ack_i) 
          begin
            if (umif_adr_i[0] && !umif_by_i) ns = BY2F; 
            else
              begin
                if (umie_stb_i && !umie_ack_o) ns = BY1E; 
                else ns = ACKF; 
              end
          end
        else ns = BY1F; 
      BY2F:    
        if (wb_ack_i) 
          if (umie_stb_i) ns = BY1E; 
          else ns = ACKF; 
        else ns = BY2F; 
      ACKF:    
        if (umie_stb_i) ns = BY1E; 
        else ns = IDLE; 
    endcase
endmodule
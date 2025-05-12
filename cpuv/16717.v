module altpcierd_icm_npbypassctl   # (
    parameter TXCRED_WIDTH = 22
)( clk, rstn,
    tx_cred, data_in, data_valid, data_ack, tx_bridge_idle,
    tx_npcredh, tx_npcredd, tx_npcredh_infinite, tx_npcredd_infinite,
    np_data_in, np_fifo_wrempty, np_fifo_rdempty, np_data_ack,
    ena_np_bypass,  tx_mask, got_cred, sending_np, sending_npd,
    tx_ack, req_npbypass_pkt );
    input         clk;
    input         rstn;
    input [65:0]  tx_cred;             
    input [107:0] data_in;             
    input         data_valid;          
    input         data_ack;
    input         tx_bridge_idle;      
    input         np_fifo_wrempty;     
    input         np_fifo_rdempty;     
    input[107:0]  np_data_in;          
    input         np_data_ack;
    input[7:0]    tx_npcredh;          
    input[11:0]   tx_npcredd;          
    input         tx_npcredh_infinite; 
    input         tx_npcredd_infinite; 
    input         tx_ack;
    input         sending_np;          
    input         sending_npd;         
    output        req_npbypass_pkt;    
    output        tx_mask;             
    output        ena_np_bypass;       
    wire          ena_np_bypass;
    reg           ena_np_bypass_r;     
    reg           tx_mask;             
    wire          sim_npreq;           
    reg           got_nph_cred;        
    reg           got_npd_cred;        
    wire          req_npbypass_pkt;
    reg[10:0]     sim_count;           
    reg           sim_sop_del;         
    wire          got_cred;            
    wire          got_nph_cred_c;      
    wire          got_npd_cred_c;      
    reg           flush_np_bypass;     
    reg           np_tx_ack_del;       
    assign sim_npreq   = data_in[`STREAM_NP_REQ_FLAG];
    assign ena_np_bypass    = (data_in[`STREAM_NP_SOP_FLAG] &
                               (~got_nph_cred_c | (~got_npd_cred_c & data_in[`STREAM_NP_WRREQ_FLAG])))  ? 1'b1 :  np_fifo_wrempty  ? 1'b0 : ena_np_bypass_r;
    assign req_npbypass_pkt = flush_np_bypass;
    assign got_nph_cred_c = (TXCRED_WIDTH == 22) ? (tx_npcredh[0] & ~np_tx_ack_del) : got_nph_cred;
    assign got_npd_cred_c = (TXCRED_WIDTH == 22) ? (tx_npcredd[0] & ~np_tx_ack_del) : got_npd_cred;
    assign got_cred       = 1'b0;
    always @ (posedge clk or negedge rstn) begin
        if (~rstn) begin
            ena_np_bypass_r    <= 1'b0;
            tx_mask            <= 1'b0;
            sim_sop_del        <= 1'b0;
            sim_count          <= 11'h0;
            got_nph_cred       <= 1'b0;
            got_npd_cred       <= 1'b0;
            flush_np_bypass    <= 1'b0;
            np_tx_ack_del      <= 1'b0;
        end
        else begin
            ena_np_bypass_r    <= ena_np_bypass;
            np_tx_ack_del      <= tx_ack & sending_np;
            if (tx_npcredh_infinite)       got_nph_cred <= 1'b1;
            else if (tx_ack & sending_np)  got_nph_cred <= |tx_npcredh[7:1];
            else                           got_nph_cred <= |tx_npcredh;
            if (tx_npcredd_infinite)       got_npd_cred <= 1'b1;
            else if (tx_ack & sending_npd) got_npd_cred <= |tx_npcredd[11:1];
            else                           got_npd_cred <= |tx_npcredd;
            if (np_fifo_rdempty) begin
                flush_np_bypass <= 1'b0;
            end
            else if (np_data_in[`STREAM_NP_SOP_FLAG]) begin
                flush_np_bypass <=  got_nph_cred_c & (got_npd_cred_c | ~np_data_in[`STREAM_NP_WRREQ_FLAG]);
            end
            else begin
                flush_np_bypass <= 1'b0;
            end
            sim_sop_del <= data_valid ? data_in[`STREAM_SOP] : sim_sop_del;
            if (data_in[`STREAM_NP_REQ_FLAG] & data_in[`STREAM_SOP] & ~sim_sop_del)
                sim_count <= sim_count + 1;
            tx_mask <= (~got_nph_cred_c | (~got_npd_cred_c & data_in[`STREAM_NP_WRREQ_FLAG])) ? 1'b1 : np_fifo_wrempty ? 1'b0 : tx_mask;
        end
    end
endmodule
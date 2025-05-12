module pipeline_agent
(
	input  wire  									clk,  
	input  wire  									rst_n,  
	input  wire                                     find_pipeline_schedule,  
    input  wire                                     direct_pipeline_schedule,  
	input  wire  [0:`NUMBER_OF_FTHREADS-1]    		fthreads_state,  
	input  wire  [0:`NUMBER_OF_FTHREADS-1]          src_job_fthread_mapping,  
	input  wire  [0:`NUMBER_OF_FTHREADS-1]          dst_job_fthread_mapping,  
    output reg   [0:`NUMBER_OF_FTHREADS-1]          src_fthread_select,  
    output reg   [0:`NUMBER_OF_FTHREADS-1]          dst_fthread_select,  
    output reg 										dst_fthread_reserve,  
    output reg  									pipeline_schedule_valid  
);
wire  [0:`NUMBER_OF_FTHREADS-1]			dst_job_mapping_shifted;
wire  [0:`NUMBER_OF_FTHREADS-1]			pipeline_src_job_mapping;
wire  [0:`NUMBER_OF_FTHREADS-1]			valid_pipeline_mapping_src;
wire  [0:`NUMBER_OF_FTHREADS-1]			src_job_mapping_shifted;
wire  [0:`NUMBER_OF_FTHREADS-1]			pipeline_dst_job_mapping;
wire  [0:`NUMBER_OF_FTHREADS-1]			valid_pipeline_mapping_dst;
wire  [0:`NUMBER_OF_FTHREADS-1]			valid_pipeline_mapping_both;
wire  [0:`NUMBER_OF_FTHREADS-1]			src_fthread_select_b;
wire  [0:`NUMBER_OF_FTHREADS-1]			dst_fthread_select_b;
wire  [0:`NUMBER_OF_FTHREADS-1]			src_fthread_select_s;
wire  [0:`NUMBER_OF_FTHREADS-1]			dst_fthread_select_s;
wire  [0:`NUMBER_OF_FTHREADS-1]         src_fthread_select_a;
wire  [0:`NUMBER_OF_FTHREADS-1]         dst_fthread_select_a;
wire  [0:`NUMBER_OF_FTHREADS-1]         dst_fthread_select_r;
wire  [0:`NUMBER_OF_FTHREADS-1]         valid_mapping_src;
wire  [0:`NUMBER_OF_FTHREADS-1]         valid_mapping_dst;
genvar k;
generate if(`NUMBER_OF_FTHREADS > 1) begin
    assign valid_mapping_src        = src_job_fthread_mapping & ~fthreads_state;
    assign valid_mapping_dst        = dst_job_fthread_mapping & ~fthreads_state;
    for ( k = `NUMBER_OF_FTHREADS-1; k >1 ; k = k-1) begin: ft_selected_src_a
        assign src_fthread_select_a[k] = valid_mapping_src[k] & ~(|(valid_mapping_src[0:k-1]));
    end
    assign src_fthread_select_a[1] = valid_mapping_src[1] & ~valid_mapping_src[0];
    assign src_fthread_select_a[0] = valid_mapping_src[0];
    for ( k = `NUMBER_OF_FTHREADS-1; k >1 ; k = k-1) begin: ft_selected_dst_a
        assign dst_fthread_select_a[k] = valid_mapping_dst[k] & ~(|(valid_mapping_dst[0:k-1]));
    end
    assign dst_fthread_select_a[1] = valid_mapping_dst[1] & ~valid_mapping_dst[0];
    assign dst_fthread_select_a[0] = valid_mapping_dst[0];
    for ( k = `NUMBER_OF_FTHREADS-1; k >1 ; k = k-1) begin: ft_selected_dst_r
        assign dst_fthread_select_r[k] = dst_job_fthread_mapping[k] & ~(|(dst_job_fthread_mapping[0:k-1]));
    end
    assign dst_fthread_select_r[1] = dst_job_fthread_mapping[1] & ~dst_job_fthread_mapping[0];
    assign dst_fthread_select_r[0] = dst_job_fthread_mapping[0];
    assign dst_job_mapping_shifted    = {dst_job_fthread_mapping[1:`NUMBER_OF_FTHREADS-1], 1'b0};
    assign pipeline_src_job_mapping   = dst_job_mapping_shifted & src_job_fthread_mapping;
    assign valid_pipeline_mapping_src = pipeline_src_job_mapping & ~fthreads_state;
    assign src_job_mapping_shifted    = {1'b0, src_job_fthread_mapping[0:`NUMBER_OF_FTHREADS-2]};
    assign pipeline_dst_job_mapping   = src_job_mapping_shifted & dst_job_fthread_mapping;
    assign valid_pipeline_mapping_dst = pipeline_dst_job_mapping & ~fthreads_state;
    assign valid_pipeline_mapping_both = {valid_pipeline_mapping_dst[1:`NUMBER_OF_FTHREADS-1], 1'b0} &
                                         valid_pipeline_mapping_src;
    for ( k = `NUMBER_OF_FTHREADS-1; k >1 ; k = k-1) begin: ft_selected_src_b
        assign src_fthread_select_b[k] = valid_pipeline_mapping_both[k] & ~(|(valid_pipeline_mapping_both[0:k-1]));
    end
    assign src_fthread_select_b[1] = valid_pipeline_mapping_both[1] & ~valid_pipeline_mapping_both[0];
    assign src_fthread_select_b[0] = valid_pipeline_mapping_both[0];
    assign dst_fthread_select_b = {1'b0, src_fthread_select_b[0:`NUMBER_OF_FTHREADS-2]};
    for ( k = `NUMBER_OF_FTHREADS-1; k >1 ; k = k-1) begin: ft_selected_src_s
        assign src_fthread_select_s[k] = valid_pipeline_mapping_src[k] & ~(|(valid_pipeline_mapping_src[0:k-1]));
    end
    assign src_fthread_select_s[1] = valid_pipeline_mapping_src[1] & ~valid_pipeline_mapping_src[0];
    assign src_fthread_select_s[0] = valid_pipeline_mapping_src[0];
    assign dst_fthread_select_s = {1'b0, src_fthread_select_s[0:`NUMBER_OF_FTHREADS-2]};
    always @(posedge clk) begin
        if (~rst_n) begin
            src_fthread_select       <= 0;
            dst_fthread_select       <= 0;
            dst_fthread_reserve      <= 0;
            pipeline_schedule_valid  <= 0;
        end
        else begin
            if(direct_pipeline_schedule) begin
                if (|src_fthread_select_b) begin
                    src_fthread_select       <= src_fthread_select_b;
                    dst_fthread_select       <= dst_fthread_select_b;
                    dst_fthread_reserve      <= 1'b0;
                end
                else begin
                    src_fthread_select       <= src_fthread_select_s;
                    dst_fthread_select       <= dst_fthread_select_s;
                    dst_fthread_reserve      <= 1'b1;
                end
            end
            else begin
                src_fthread_select       <= src_fthread_select_a;
                dst_fthread_select       <= 0;
                dst_fthread_reserve      <= 1'b0;
                if(|src_fthread_select_a) begin
                    if(|dst_fthread_select_a) begin
                        dst_fthread_select       <= dst_fthread_select_a;
                    end
                    else begin
                        dst_fthread_select       <= dst_fthread_select_r;
                        dst_fthread_reserve      <= 1'b1;
                    end
                end
            end
            pipeline_schedule_valid  <= find_pipeline_schedule;
        end
    end
end
else begin
    always @(posedge clk) begin
        src_fthread_select       <= 0;
        dst_fthread_select       <= 0;
        dst_fthread_reserve      <= 0;
        pipeline_schedule_valid  <= 0;
    end
end
endgenerate
endmodule
module bus
	begin
		case( dma_regsel )
		DMA_MODULE_ZX:
			dma_dout_modules <= dma_dout_zx;
		default:
			dma_dout_modules <= 8'bxxxxxxxx;
		endcase
	end
endmodule
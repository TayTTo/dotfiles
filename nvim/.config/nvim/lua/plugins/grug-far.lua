return {
	'MagicDuck/grug-far.nvim',
	config = function()
		require('grug-far').setup({
			-- options, see Configuration section below
			-- there are no required options atm
			-- engine = 'ripgrep' is default, but 'astgrep' or 'astgrep-rules' can
			-- be specified
		});
	end
}

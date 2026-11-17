return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').install {
      'bash', 'c', 'cpp', 'css', 'diff', 'html',
      'javascript', 'jsdoc', 'json', 'lua', 'luadoc',
      'markdown', 'markdown_inline', 'query', 'regex',
      'toml', 'tsx', 'typescript', 'vim', 'vimdoc',
      'hyprlang',
    }
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('treesitter-start', { clear = true }),
      callback = function(args)
        if not pcall(vim.treesitter.start, args.buf) then
          return
        end
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}

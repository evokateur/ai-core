# Setup for Molten.nvim

In order to attach to the kernel when working with [`molten.nvim`](https://github.com/benlubas/molten.nvim) you need to install the kernel spec for the `llms` environment.

```sh
```
python -m ipykernel install --user --env VIRTUAL_ENV $(pwd)/llms --name=llm_engineering --display-name "LLM Engineering"
```



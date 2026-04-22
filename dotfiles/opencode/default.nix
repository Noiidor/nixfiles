{pkgs, ...}: let
  customProviderName = "302.ai-custom";
  planAgentModel = "${customProviderName}/qwen3.6-plus";
  primaryAgentModel = "${customProviderName}/MiniMax-M2.7";
in {
  config = (pkgs.formats.json {}).generate "opencode.json" {
    autoupdate = false;
    permission = {
      bash = "ask";
    };
    watcher = {
      ignore = ["node_modules/**" "dist/**" ".git/**"];
    };
    experimental = {
      lsp = true;
    };
    agent = {
      plan = {
        model = planAgentModel;
      };
      build = {
        model = primaryAgentModel;
      };
    };
    provider = {
      "${customProviderName}" = {
        name = customProviderName;
        options = {
          baseURL = "https://api.302.ai";
        };
        models = {
          "MiniMax-M2.5" = {
            name = "MiniMax M2.5";
            limit = {
              context = 204800;
              output = 65500;
            };
          };
          "MiniMax-M2.7" = {
            name = "MiniMax M2.7";
            limit = {
              context = 204800;
              output = 65500;
            };
          };
          "glm-5.1" = {
            name = "GLM 5.1";
            limit = {
              context = 200000;
              output = 65500;
            };
          };
          "qwen3.6-plus" = {
            name = "Qwen 3.6 Plus";
            limit = {
              context = 992000;
              output = 65500;
            };
          };
          "qwen3.6-flash" = {
            name = "Qwen 3.6 Flash";
            limit = {
              context = 1000000;
              output = 65500;
            };
          };
        };
      };
    };
  };
}

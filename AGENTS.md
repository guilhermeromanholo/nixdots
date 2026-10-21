# Diretrizes da refatoração NixOS

Este documento registra as decisões acordadas com o usuário para a nova configuração. Aplica-se a todo o repositório. Instruções posteriores do usuário prevalecem sobre este documento.

## Escopo e estado do trabalho

- A configuração antiga está em `old/` e serve como referência de comportamento, hardware, serviços e persistência.
- A nova configuração será criada na raiz do repositório.
- O usuário autorizou a implementação da nova configuração após o registro destas decisões.
- Preservar `old/` durante a migração. Não apagar nem sobrescrever configurações pessoais existentes para facilitar a implementação.
- O inventário antigo não representa integralmente o uso atual: aplicar as decisões abaixo em vez de migrar todos os programas automaticamente.

## Hosts e usuários

Usar identificadores de hosts em minúsculas na configuração.

| Host | Perfil | Usuário principal | Tema fixo |
| --- | --- | --- | --- |
| `sunset` | Desktop/workstation | `guilherme` | Gruvbox |
| `taz` | Desktop/workstation | `guilherme` | Nord |
| `vortex` | NixOS no WSL | `guilherme` | Nord |
| `tesla` | Lenovo ThinkPad T480 | `guilherme` | Gruvbox |

- Vortex continua sendo WSL; atualizar também o usuário padrão do WSL para `guilherme`.
- Sunset, Taz e Tesla usarão MangoWM com Noctalia v5. Vortex terá o perfil de terminal/WSL, sem sessão de desktop adicionada automaticamente.
- O antigo host `vm` não faz parte das máquinas pessoais mantidas. Uma VM pode ser usada como ambiente de teste.
- A configuração de hardware e discos do Tesla fica para depois. Não inventar UUIDs, dispositivos, partições, GPU ou configuração de boot. Não apresentar Tesla como pronto para ativação enquanto esses dados estiverem pendentes.
- Preservar hardware, layout de discos, caminhos de persistência e `system.stateVersion` dos hosts existentes durante a refatoração, salvo mudança expressamente solicitada. Não elevar `stateVersion` apenas por atualizar o nixpkgs.
- A mudança de usuário do Vortex exige tratar separadamente os dados do antigo usuário `nixos`; não mover ou apagar esses dados automaticamente.

## Arquitetura dendrítica

- Usar flake-parts e o sistema de módulos do Nix para composição.
- Não usar den, flake-aspects ou outra biblioteca externa de arquitetura/composição. Isso não exclui dependências funcionais necessárias, como nix-wrapper-modules, disko, impermanence e NixOS-WSL.
- Organizar por funcionalidades. Cada módulo de flake-parts reúne as contribuições pertinentes de uma funcionalidade: módulos NixOS, wrappers, pacotes e verificações.
- Usar `flake.modules.nixos.*`, com o módulo nativo correspondente do flake-parts, e `flake.nixosConfigurations.*` para montar os hosts.
- Compor perfis e hosts explicitamente. Registrar uma funcionalidade não deve ativá-la em todas as máquinas.
- Começar com imports explícitos. Não adicionar uma dependência de descoberta automática de arquivos.
- Substituir a camada antiga `parts.*` pelos recursos nativos disponíveis. Não recriar um framework próprio para funcionalidades já atendidas pelo flake-parts.
- Separar o escopo de avaliação do flake, dos módulos NixOS e dos wrappers, evitando recursão ao compartilhar configurações.

## Contratos compartilhados

- Adotar a ideia de contratos do repositório Goxore: interfaces pequenas e explícitas entre funcionalidades, declaradas como opções tipadas do sistema de módulos.
- Concentrar em `modules/contracts/` as interfaces que realmente são compartilhadas, como tema, usuário principal, persistência e, quando necessário, atalhos de sessão.
- Os consumidores dependem do contrato, não de detalhes internos de outra funcionalidade. Hosts e perfis fornecem os valores apropriados.
- Declarar tipos, valores padrão quando fizerem sentido e descrições. Validar invariantes relevantes; evitar grandes conjuntos de atributos sem estrutura para configurações conhecidas.
- Não criar contratos especulativos nem copiar o mecanismo de avaliação próprio do Goxore. A implementação deve continuar baseada em flake-parts.
- Não usar um contrato global com valores de um host para configurar silenciosamente todos os outros hosts.

## Wrappers, pacotes e overlay

- Remover o Home Manager por completo da nova configuração. Não usar adaptadores que executem módulos Home Manager por trás de wrappers, nem substituí-lo por outro gerenciador geral de dotfiles.
- Usar nix-wrapper-modules para aplicativos que precisem de configuração. Consultar primeiro os módulos prontos da versão fixada; estendê-los quando adequados e criar wrappers locais quando necessário.
- Usar a integração oficial do nix-wrapper-modules com flake-parts, conforme a API da revisão fixada.
- Exportar wrappers reutilizáveis e pacotes executáveis. As opções do wrapper devem permitir personalização sem duplicar a definição do aplicativo.
- Disponibilizar os pacotes e wrappers concretizados por um overlay com namespace próprio, inspirado no Goxore. Usar `pkgs.nixdots.<programa>` como convenção inicial para os pacotes configurados, sem substituir indiscriminadamente os atributos originais do nixpkgs.
- Manter uma única definição de cada wrapper, compartilhada pelas exportações do flake e pelo overlay. Evitar ciclos entre `self.packages`, o overlay e o conjunto `pkgs` usado para construir os pacotes.
- O overlay aplicado a cada host deve produzir os pacotes com o tema daquele host. Pacotes independentes exportados pelo flake devem ter padrão documentado e aceitar personalização.
- Instalar os pacotes pelo NixOS, usando pacotes por usuário quando apropriado. Configurar serviços, usuários, hardware e integração de sessão por módulos NixOS.
- Preferir argumentos e variáveis específicos do aplicativo para apontar para configurações no store. Não redirecionar globalmente `HOME` ou todo o ambiente XDG para diretórios imutáveis.
- Históricos, caches, sessões, perfis mutáveis e credenciais devem continuar em locais graváveis apropriados. Segredos não devem ser incluídos em derivações ou arquivos do store.
- Validar que lançadores `.desktop`, atalhos, serviços e comandos usem os executáveis configurados, e não inadvertidamente o pacote original.
- Para programas que não permitem separar configuração e estado, estudar a interface real antes de escolher uma solução. Não presumir que todo diretório de configuração pode ser imutável nem criar um gerenciador genérico de symlinks como solução padrão.
- Revisar também dependências transitivas ao remover Home Manager e Stylix; remover um input direto não garante que ele desapareça do lock.

## Tema

- Remover Stylix da nova configuração.
- Tema fixo e declarativo por host, aplicado por rebuild. Não implementar troca dinâmica de paleta ou geração de cores a partir de wallpaper nesta migração.
- Reaproveitar Gruvbox e Nord de `old/themes/` como ponto de partida.
- Definir contrato central para paleta Base16, cores semânticas, fontes, tamanhos, cursor, ícones, wallpaper e parâmetros visuais compartilhados.
- Cada aplicativo terá um adaptador para seu formato. Compartilhar valores entre Fish, Starship, Helix, terminal, Mango, Noctalia e integrações GTK/Qt.
- Passar o tema explicitamente à composição dos wrappers para permitir temas diferentes entre hosts.
- Verificar a precedência das configurações e alterações persistidas pela interface do Noctalia para preservar o tema escolhido em Nix.

## Shell e editor

- Fish é o shell principal, com Starship como prompt.
- Configurar Fish e Starship por nix-wrapper-modules, incluindo integrações efetivamente necessárias. O módulo NixOS cuida do registro e seleção do shell de login.
- Remover Zsh e Powerlevel10k da nova configuração. Reavaliar aliases e integrações antigos antes de transportá-los.
- Inicializar prompt e recursos interativos apenas nos contextos apropriados. Testar terminal, login, SSH e execução não interativa.
- Preservar estado gravável do Fish, incluindo histórico e variáveis universais quando usadas; incluir persistência onde necessária.
- Helix é o único editor a migrar. Remover Nixvim, `nixvim-custom`, Zed e VSCodium e suas dependências exclusivas da nova configuração.
- Usar o wrapper pronto de Helix quando adequado, com configurações, tema e linguagens declarados em Nix.
- Configurar `nixd` para Nix e `ty` para Python, com os executáveis disponíveis explicitamente ao Helix.
- Apontar `EDITOR` e `VISUAL` para o Helix configurado.
- Nenhum formatador adicional foi escolhido. Não presumir adoção de Ruff, Black ou outro servidor/formatador além dos solicitados.
- Configurações pessoais atuais de Helix, Fish e Starship ainda podem ser fornecidas; não inventar preferências de atalhos ou prompt como se já estivessem acordadas.

## Desktop e integração do sistema

- Migrar os desktops antigos para MangoWM + Noctalia v5.
- Usar explicitamente o pacote e os formatos de configuração da v5; não reutilizar configuração da v4 baseada em Quickshell.
- Empacotar a configuração do compositor e do Noctalia com wrappers, aproveitando módulos prontos quando disponíveis.
- Aproveitar inicialmente o greetd/tuigreet existente, salvo necessidade concreta identificada durante a implementação.
- Definir um único responsável pela inicialização do Noctalia; a proposta inicial é o autostart do compositor. Não duplicar a inicialização com um serviço de usuário concorrente.
- Integrar áudio, rede, Bluetooth quando aplicável, energia, portais, autenticação, bloqueio e suspensão.
- Transportar o comportamento necessário dos atalhos, monitores e regras de janelas existentes, adaptando-o ao Mango.
- Substituir barras e launchers antigos pelas funções correspondentes do Noctalia conforme a cobertura validada. Não manter serviços redundantes de notificações, barras ou wallpaper.
- Para Tesla, prever perfil de laptop; detalhes de bateria, tampa, suspensão, TrackPoint/touchpad e monitores serão validados com o hardware real.

## Persistência e migração

- Migrar a persistência atualmente configurada via Home Manager para o módulo NixOS de impermanence.
- Preservar os caminhos reais dos dados existentes. Não alterar a disposição de `/persist` sem uma migração explícita.
- Distinguir configuração reproduzível de estado mutável; evitar persistir arquivos gerados apenas por inércia da configuração antiga.
- Manter serviços necessários de cada host, como virtualização e Tailscale, conforme inventário. A simplificação acordada de editores e shell não autoriza remover serviços independentes.

## Sequência e critérios de validação

1. Inventariar funcionalidades ainda relevantes de `old/` e fixar as dependências da nova configuração.
2. Implementar a base flake-parts, os contratos e a composição dos hosts.
3. Implementar o tema, os wrappers de Fish, Starship e Helix e o overlay compartilhado.
4. Integrar Mango, Noctalia e a sessão gráfica; validar em ambiente de teste.
5. Migrar os demais aplicativos necessários, serviços e persistência.
6. Validar os hosts com hardware disponível. Manter Tesla explicitamente pendente até receber seus dados.
7. Revisar dependências e documentar ativação e rollback.

- Executar avaliação, `nix flake check` e builds apropriados de wrappers e configurações NixOS.
- Verificar os temas diferentes por host, o funcionamento de `nixd` e `ty`, a seleção dos wrappers nos lançadores e a separação entre configuração e estado.
- Validar em sessão real login, áudio, atalhos, launcher, portais, bloqueio e suspensão. Um build bem-sucedido não comprova esses comportamentos.
- Não realizar reparticionamento, ativação nos hosts ou migração de dados como efeito colateral dos testes.
- Na análise inicial, `nix` não estava disponível neste ambiente. Verificar novamente ao implementar e relatar claramente quais validações foram ou não executadas.

## Referências e limites da análise

- https://github.com/Goxore/nixconf/ — inspiração para contratos, organização por funcionalidades, wrappers e exposição de pacotes. Os arquivos consultados usam uma estrutura própria com tack; não copiar essa infraestrutura.
- https://github.com/linusammon/nixos-config/ — exemplos de Helix, Noctalia e tema central. Sua composição por combinação de atributos, configuração NixOS de Fish/Starship e serviço próprio de symlinks não são decisões adotadas por este projeto.
- https://git.voidarc.co.uk/voidarc/nixos — referência fornecida pelo usuário, ainda não analisada devido a HTTP 403. Não atribuir decisões técnicas a ela sem consultar o código.
- Consultar a documentação e o código das revisões efetivamente fixadas antes de depender de APIs, nomes de módulos ou opções. As referências externas podem mudar.

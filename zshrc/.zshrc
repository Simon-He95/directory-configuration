# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="spaceship"

# plugins
plugins=(git zsh-syntax-highlighting zsh-autosuggestions zsh-nvm zsh-z web-search)

source $ZSH/oh-my-zsh.sh
source ~/.bash_profile
# User configuration
# -------------------------#
#  Node Package Manager
# -------------------------#
# alias - ni

alias nio="ni --prefer-offline"
alias d="nr dev"
alias s="nr start"
alias b="nr build"
alias bw="nr build --watch"
alias t="nr test"
alias t="nr test -u"
alias w="nr watch"
alias lint="nr lint"
alias lintf="nr lint:fix"
alias s="nr start"
alias p="nr play || d"
alias pr="nr preview"
alias pb="nr play:build || b"
alias release="npm run release"
alias updateVersion="git add . && git commit -m 'chore: update version' && git push"
alias clean="git add . && git commit -m 'chore: clean' && git push"
alias v="npm view"
alias lock="pnpm install --no-frozen-lockfile"

#--------------------------#
# project simple
# -------------------------#

alias cls="clear"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

#--------------------------#
# Git
# -------------------------#

alias gs="git status"
alias gcc="git checkout"
alias gccb="git checkout -b"
alias gl="git log"
alias glo="git log --online --graph"
alias gb="git branch"
alias gbd="git branch -d"
alias gba="git branch -a"
alias gc="git add . && git commit -m"
alias ga="git add ."
alias gs="git status"
alias gpl="git pull --rebase"
alias gpf="git push --force"
alias gpt="git push origin --tags"
alias gptf="git push origin --tags -f"
alias gp="git push"
alias gst="git stash"
alias rebase="git rebase"
alias reset="git reset HEAD"
alias reset1="git reset HEAD~1"
alias main="git checkout main"
alias use="nrm use"
alias unproxy="git config --global --unset http.proxy && git config --global --unset https.proxy"
alias proxy="git config --global http.proxy http://127.0.0.1:57932 && git config --global https.proxy https://127.0.0.1:57932"
alias pullmaster="git pull origin master"
alias pullmain="git pull origin main"
alias flog="git reflog"
alias see="ps -ef|grep"

#--------------------------#
# Pnpm
# -------------------------#

run() {
  command="$2"
  if [ "$2" = "" ]; then
    pnpm run $1
    return
  elif [ "$2" = "i" -o "$2" = "install" ]; then
    data=$*
    len1=$1
    len2=$2
    result="pnpm --filter "$1" i ${data:$(expr ${#len1} + ${#len2} + 2)}"
    eval $result
    return
  elif [ "$2" = "un" -o "$2" = "uninstall" ]; then
    data=$*
    len1=$1
    len2=$2
    result="pnpm --filter "$1" uninstall ${data:$(expr ${#len1} + ${#len2} + 2)}"
    eval $result
    return
  elif [ "$2" = "d" ]; then
    command="dev"
  elif [ "$2" = "b" ]; then
    command="build"
  elif [ "$2" = "t" ]; then
    command="test"
  elif [ "$2" = "p" ]; then
    command="playground"
  elif [ "$2" = "pr" ]; then
    command="preview"
  fi
  pnpm --filter $1 run $command
}

# 创建git tag
tag() {
  echo "请输入tagname:"
  read tagname
  if [ "$tagname" = "" ]; then
    echo "输入的tagname为空"
    exit 1
  fi

  echo "请输入描述:"

  read detail
  if [ -n "detail" ]; then
    detail="say nothing"
  fi
  if [ "$?" = 0 ]; then
    git tag -a $tagname -m $detail
  fi
}

# 自动生成.gitignore
ignore() {
  if [ -f ".gitignore" ]; then
    echo "gitignore已存在"
    return
  fi
  echo "...正在生成.gitignore"
  touch .gitignore                                                                                                                                # 创建文件
  echo "*.DS_Store  \nnode_modules \n*.log \nidea/ \n*.local \n.DS_Store \ndist \n.cache \n.idea \nlogs \n&-debug.log \n*-error.log" >>.gitignore # 添加内容
}

# clone
clone() {
  str=$1
  str1=${str##*/}
  result=${str1%.*}
  echo "正在clone $result"
  if [ ! $2 ]; then
    git clone $str && echo "下载完成,正在打开 $$result" && code $result && cd $result && echo '正在下载依赖' && ni
  else
    git clone $str && echo "下载完成,正在打开 $$result" && code $result && cd $result && echo '正在下载依赖' && ni || ni || ni || echo '安装依赖失败，请重新尝试' && echo "正在执行 nr $2" && nr $2 || eval ${2}
  fi
}

# template
template() {
  echo "请输入模板: ts | vue"
  read templateName
  if [ ! $1 ]; then
    echo "请输入模板名称"
    return 0
  fi

  if [ $templateName = "ts" ]; then
    echo "正在创建$1目录,下载starter-ts模板,请稍等..."
    if [ ! $2 ]; then
      npx degit Simon-He95/starter-ts $1 && echo "正在打开$1" && code $1 && cd $1 && find ./ -type f -path "./package.json" | xargs sed -i "s:pkg-name:$1:g" && echo '正在下载依赖' && ni
    else
      npx degit Simon-He95/starter-ts $1 && echo "正在打开$1" && code $1 && cd $1 && find ./ -type f -path "./package.json" | xargs sed -i "s:pkg-name:$1:g" && echo '正在下载依赖' && ni || ni || ni || echo '安装依赖失败，请重新尝试' && echo "正在执行 nr $2" && nr $2 || eval ${2}
    fi
  else
    if [ $templateName = "vue" ]; then
      echo "正在创建$1目录,下载vitesse-lite模板,请稍等..."
      if [ ! $2 ]; then
        npx degit Simon-He95/vitesse-lite $1 && echo "正在打开$1" && code $1 && cd $1 && find ./ -type f -path "./package.json" | xargs sed -i "s:pkg-name:$1:g" && echo '正在下载依赖' && ni
      else
        npx degit Simon-He95/vitesse-lite $1 && echo "正在打开$1" && code $1 && cd $1 && find ./ -type f -path "./package.json" | xargs sed -i "s:pkg-name:$1:g" && echo '正在下载依赖' && ni || ni || ni || echo '安装依赖失败，请重新尝试' && echo "正在执行 nr $2" && nr $2 || eval ${2}
      fi
    else
      echo "模板不存在"
    fi
  fi
}

# remove
remove() {
  if [ ! $1 ]; then
    echo "请输入要删除的目录名称"
    return 0
  fi
  if [ ! -f $1 ] && [ ! -d $1 ]; then
    echo '文件或目录不存在'
    return 0
  else
    echo "正在删除$1目录"
    rimraf $1 && echo "删除成功" || echo "删除失败,请重新尝试"
    return 1
  fi
}

# reni
reni() {
  remove node_modules
  if [ $? = 1 ]; then
    ni || ni || ni
  fi
}

# 包裹ni
nii() {
  ni $* || nio $*
}

# pkginit
pkginit() {
  echo "请输入包名:"
  read pkgname
  if [ ! $pkgname ]; then
    echo "包名不能为空"
    return 0
  fi
  if [ -f package.json ]; then
    echo 'package.json已存在'
    return 0
  fi

  touch package.json
  echo '{
  "name": "'$pkgname'",
  "version": "0.0.0",
  "packageManager": "pnpm@6.32.3",
  "description": "'$pkgname'",
  "author": "Simon He",
  "license": "MIT",
  "repository": {
    "type": "git",
    "url": "git + git@github.com:Simon-He95/'$pkgname'.git"
  },
  "bugs": {
    "url": "https://github.com/Simon-He95/'$pkgname'/issues"
  },
  "keywords": [
    "'$pkgname'"
  ],
  "exports": {
    ".": {
      "types": "./dist/index.d.ts",
      "require": "./dist/index.js",
      "import": "./dist/index.mjs"
    }
  },
  "main": "./dist/index.js",
  "module": "./dist/index.mjs",
  "types": "./dist/index.d.ts",
  "files": [
    "dist"
  ],
  "scripts": {
    "build": "pkgroll --minify",
    "dev": "pkgroll --watch",
    "play": "pnpm run -C playground dev",
    "play:build": "pnpm run -C playground build",
    "serve": "pnpm run -C playground serve",
    "lint": "eslint .",
    "lint:fix": "eslint . --fix",
    "typecheck": "vue-tsc --noEmit",
    "test": "vitest -u",
    "test:e2e": "cypress open",
    "prepublishOnly": "nr build",
    "release": "bumpp --commit --tag --push && pnpm publish"
  },
  "dependencies": {
    "@vueuse/core": "^8.1.1",
    "vue": "^3.2.36"
  },
  "devDependencies": {
    "@antfu/eslint-config": "^0.25.0",
    "@types/node": "^17.0.38",
    "bumpp": "^7.1.1",
    "eslint": "^8.16.0",
    "eslint-plugin-n": "^15.2.1",
    "pkgroll": "^1.3.1",
    "typescript": "^4.7.2",
    "vitest": "^0.7.0"
  },
  "eslintConfig": {
    "extends": "@antfu"
  }
}' >>package.json
  if [ $? = 0 ]; then
    echo '创建成功'
  else
    echo '创建失败'
  fi
}

fpath=($fpath "/home/simon/.zfunctions")

# Set Spaceship ZSH as a prompt
autoload -U promptinit
promptinit
prompt spaceship

export PNPM_HOME="/home/simon/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

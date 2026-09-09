#!/bin/bash
#
# Chelsie Zhang 个人主页 - 一键部署工具
# 用法:
#   ./deploy.sh          # 提交所有改动并推送到 GitHub Pages
#   ./deploy.sh "修改说明"  # 带修改说明的提交推送
#
# 推送后 1-2 分钟自动上线，访问 https://chelsiezhang.github.io
#

cd "$(dirname "$0")"

echo "=============================="
echo "  个人主页一键部署工具"
echo "=============================="
echo ""

# 检查是否有改动
if git diff --quiet && git diff --cached --quiet && [ -z "$(git ls-files --others --exclude-standard)" ]; then
    echo "没有检测到任何改动，无需部署。"
    echo ""
    echo "提示: 先修改 index.html，再运行此脚本。"
    exit 0
fi

# 显示改动概要
echo "检测到以下改动:"
git status --short
echo ""

# 提交信息
COMMIT_MSG="${1:-更新个人主页内容}"
echo "提交说明: $COMMIT_MSG"
echo ""

# 提交并推送
git add -A
git commit -m "$COMMIT_MSG"

# 推送（使用存储的凭据）
if git push origin main 2>&1; then
    echo ""
    echo "=============================="
    echo "  部署成功！"
    echo "=============================="
    echo ""
    echo "网址: https://chelsiezhang.github.io"
    echo "约 1-2 分钟后生效，刷新即可看到最新内容。"
else
    echo ""
    echo "推送失败，可能需要重新认证。"
    echo "请运行: git remote set-url origin https://chelsiezhang:<你的Token>@github.com/chelsiezhang/chelsiezhang.github.io.git"
    exit 1
fi

#!/bin/bash
source /app/functions.sh

  replace_from_env "redirect_url" "${redirect_url:-"https://google.com"}"
  replace_from_env "redirect_code" "${redirect_code:="302"}"
  
# data directories - should be on secure media
STORE_DIR='/tmp/deaddrop/store'
GPG_KEY_DIR='/tmp/deaddrop/keys'

SOURCE_TEMPLATES_DIR='./source_templates'
JOURNALIST_TEMPLATES_DIR='./journalist_templates'
WORD_LIST='./wordlist'

HMAC_SECRET='c75f391d54717cbfbd89d3a5597dacad0eab42242661512d18d8087a3c842128' # $ date | sha256sum
JOURNALIST_KEY=''
BCRYPT_SALT='$2a$12$gLZnkcyhZBrWbCZKHKYgKee8g/Yb9O7.24/H.09Yu9Jt9hzW6n0Ky' # bcrypt.gensalt()

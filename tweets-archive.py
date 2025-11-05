import json

X_USERNAME   = 'kaivongdev' # identical to github username
X_DOMAIN_URL = 'HTTPS://X.com'.lower()
X_UNSPECIFIC_INBETWEEN_HAPPENINGS = '/'
X_USER_TWEETS_JSON_JS_FILE = 'tweets_example.json' # rename `.js` <=> `.json`

def td_entry(post_texts, line_break = True ):
    if line_break:
        new_line = "\n"
    else:
        new_line = ''
    return ("<td>%s</td>" %(post_texts)) + new_line

def tr_html(html_text):
    return "<tr>%s</tr>\n" %(html_text)

def table_html(inner_text):
    return "<table>%(inner_text)</table>"

class Tweet():
#    def tweet(self):
#        self["obj"] = self
#        self['id'] = self['tweet']['id']
#        self["full_text"] = self['tweet']["full_text"]
#        self["created_at"] = self['tweet']["created_at"]
#        return self

class UserPosts:
    def all():
        return self.all

    def all_posts(self):
        self.all = []
        return self.all

    def add_post(self,innter_text):
        self.all += [tr_html(innter_text)]

def build_tweet_user_posts():
    the_user_post = UserPosts()
    user_posts = the_user_post.all_posts()
    tweets = open(X_USER_TWEETS_JSON_JS_FILE).read()
    t_arr = json.loads(tweets)
    for tweet in t_arr:
        tweet = Tweet.tweet(tweet)
        user_resource_location  = X_DOMAIN_URL + X_UNSPECIFIC_INBETWEEN_HAPPENINGS
        user_resource_location += X_UNSPECIFIC_INBETWEEN_HAPPENINGS.join([X_USERNAME, 'status', tweet['id']])
        tweet_id = tweet['id']
        tweet_created_at = tweet['created_at']
        tweet_full_text = tweet['full_text']
        post_html = td_entry(("<a href=\"%s\">%s</a>")%(user_resource_location,tweet_id)) + td_entry(tweet_full_text)
        post_html = ' '.join([tr_html(td_entry(post_html)), td_entry(tweet_created_at)])
        the_user_post.add_post(post_html)
    return ''.join(the_user_post.all)

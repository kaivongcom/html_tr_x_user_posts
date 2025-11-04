require 'json'

X_USERNAME   = 'kaivongdev' # identical to github username
X_DOMAIN_URL = 'HTTPS://X.com'.downcase()
X_UNSPECIFIC_INBETWEEN_HAPPENINGS = '/'
#X_USER_TWEETS_JSON_JS_FILE = 'tweets.json' # rename `.js` <=> `.json`
X_USER_TWEETS_JSON_JS_FILE = 'tweets_example.json' # rename `.js` <=> `.json`

def td_entry(post_texts, line_break = true )
    new_line = "\n" if line_break
    return "<td>#{ post_texts }</td>" + new_line
end

def tr_html(html_text)
    return "<tr>#{ html_text }</tr>\n"
end

class Tweet
    attr_accessor :tweet, :id, :full_text, :created_at

    def initialize(tweet)
        @tweet = tweet["tweet"]
        @id = tweet["tweet"]["id"]
        @full_text = tweet["tweet"]["full_text"]
        @created_at = tweet["tweet"]["created_at"]
    end
end

class UserPosts
    attr_accessor :all

    def initialize()
        @all = []
    end

    def add_post(post_obj)
        @all << tr_html(post_obj)
    end
end

def build_tweet_user_posts
    user_posts = UserPosts.new()
    tweets = open(X_USER_TWEETS_JSON_JS_FILE).read()
    t_arr = JSON.load(tweets)
    t_arr.each do |tweet|
        tweet = Tweet.new(tweet)
        user_resource_location  = X_DOMAIN_URL + X_UNSPECIFIC_INBETWEEN_HAPPENINGS
        user_resource_location += [X_USERNAME, 'status', tweet.id].join(X_UNSPECIFIC_INBETWEEN_HAPPENINGS)
        tweet_id = tweet.id
        tweet_created_at = tweet.created_at
        tweet_full_text = tweet.full_text
        post_html  = td_entry("<a href=\"#{user_resource_location}\">#{tweet_id}</a>")
        post_html += td_entry(tweet_full_text) + td_entry(tweet_created_at)
        user_posts.add_post(post_html)
    end
    return user_posts.all()
end

all_user_status = build_tweet_user_posts
puts all_user_status

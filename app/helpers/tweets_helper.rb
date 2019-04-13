module TweetsHelper
  def get_tagged(tweet)
    new_message = tweet.message.split.map do |word|
      if word[0] == '#'
        tag = if Tag.pluck(:phrase).include?(word.downcase)
          Tag.find_by(phrase: word.downcase)
        else
          Tag.create(phrase: word.downcase)
        end
        TweetTag.create(tweet_id: tweet.id, tag_id: tag.id)
        "<a href='/tag_tweets?id=#{tag.id}'>#{word}</a>"
        # check to see if the # exists yet
        # make each # a link
      else
        word
      end
    end
    tweet.update(message: new_message.join(' '))
    return tweet
  end
end

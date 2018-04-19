package csci201;

import java.util.List;

public class Post {
	int postID;
	String imageURL;
	User user;
	String description;
	List<String> tags;
	List<Comment> comments;
	int numOfLikes;
	Boolean isFollow;
	Boolean isLike;
	public Post(int postID,int numOfLikes, String imageURL, String username, String userPicURL, String description, List<String> tags, List<Comment> comments) {
		this.postID = postID;
		this.numOfLikes = numOfLikes;
		this.imageURL = imageURL;
		this.user = new User(username, userPicURL);
		this.description = description;
		this.tags = tags;
		this.comments = comments;
		this.isFollow = false;
		this.isLike = false;
	}
	public int getPostID() {
		return postID;
	}
	public String getImageURL() {
		return imageURL;
	}
	public int getNumOfLikes() {
		return numOfLikes;
	}
	public String getUsername() {
		return user.getUsername();
	}
	public String getUserPicURL() {
		return user.getUserPicURL();
	}
	public String getDescription() {
		return description;
	}
	public List<String> getTags() {
		return tags;
	}
	public String getTagsToString() {
		
		String s = "[";
		
		for(int i = 0; i<tags.size(); i++) {
			if(!tags.get(i).equals("") && tags.get(i)!=null) {
			s+="\"";
			s+= tags.get(i);
			s+="\"";
			
			if(i!=tags.size()-1) {
				s+=", ";
			}
			}
		}
		s+="]";
		return s;
	}
	public List<Comment> getComments() {
		return comments;
	}
	public Boolean isFollow() {
		return isFollow;
	}
	public Boolean isLike() {
		return isLike;
	}
	public void setIsFollow(Boolean isFollow) {
		this.isFollow = isFollow;
	}
	public void setIsLike(Boolean isLike) {
		this.isLike = isLike;
	}
}
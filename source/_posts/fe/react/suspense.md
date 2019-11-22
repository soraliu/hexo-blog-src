---
title: React Suspense
date: 2019-11-22 16:54:03
tag:
- react
- data fetch
---

## Data fetch ways

### Approach 1: Fetch-on-Render

```js
function ProfilePage() {
  const [user, setUser] = useState(null);

  useEffect(() => {
    fetchUser().then(u => setUser(u));
  }, []);

  if (user === null) {
    return <p>Loading profile...</p>;
  }
  return (
    <>
      <h1>{user.name}</h1>
      <ProfileTimeline />
    </>
  );
}

function ProfileTimeline() {
  const [posts, setPosts] = useState(null);

  useEffect(() => {
    fetchPosts().then(p => setPosts(p));
  }, []);

  if (posts === null) {
    return <h2>Loading posts...</h2>;
  }
  return (
    <ul>
      {posts.map(post => (
        <li key={post.id}>{post.text}</li>
      ))}
    </ul>
  );
}
```

### Approach 2: Fetch-Then-Render (not using Suspense)


<!--stackedit_data:
eyJoaXN0b3J5IjpbMjE0NDE0OTE1NF19
-->
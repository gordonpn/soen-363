db.createUser({
  user: "example",
  pwd: "example",
  roles: [
    {
      role: "readWrite",
      db: "soen-363",
    },
  ],
});

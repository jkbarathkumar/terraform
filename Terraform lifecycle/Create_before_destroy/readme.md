### Create before Destroy

```
lifecycle {
    create_before_destroy = true
  }
```

- After adding this block, a new storage account was created first, and then the old storage account was destroyed.

While creating

![alt text](image.png)

After destroying
![alt text](image-1.png)
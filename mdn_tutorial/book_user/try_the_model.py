from models import BookUser

record_1 = BookUser(
    BookUserName="Parakeet Sings",
    BookUserEmail="parakeet@email.com"
)

record_1.save()

print(record_1)
print(record_1.BookUserName)
print(record_1.BookUserEmail)
print(record_1.BookUserGroup)
print(record_1.BookUserValidityDate)

all_users = BookUser.objects.all()
print(all_users)

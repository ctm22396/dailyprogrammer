import pyximport; pyximport.install()
from gossip_drivers import main

print(main(b'routes_ex1.txt'), '\n')
print(main(b'routes_ex2.txt'), '\n')
print(main(b'routes_chal1.txt'), '\n')
print(main(b'routes_chal2.txt'), '\n')
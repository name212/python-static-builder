# pytjhon-static-builder
Example for build python staticlly

For build use
`docker build --progress=plain . -t python-static --build-arg BUILD_THREADS=10`

Check:
```
# verify that python is static
docker run -it python-static ldd /opt/python/bin/python3
# not installed python in system
docker run -it python-static which python3
docker run -it python-static which python
# verify run
docker run -i python-static /opt/python/bin/python3 << EOD
import math
print(math.sin(3.14))
EOD
```
